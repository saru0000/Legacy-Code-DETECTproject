function [out info] = DETECTmodel(Nt_run,SWC,SoilT,SWCant_Rm,SWCant_Rr,SoilTant,Gness,AtmPress,params_swp,Xrel,ic,d13Cr,d13Cm,dx,BC,params,params_lag);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Based on soil CO2 production model developed by Fang & Moncrieff (1999)
% Agricultural and Forest Meteorology 95:225-236. But, simplify model to
% only deal with gas phase CO2 as is done in Hui & Luo (2004) Global
% Biogeochemical Cycles Vol 18:GB4029.
%
% INPUTS:
% Nt_sim = no. of time-steps to run the model for.  
% params, Xrel, SWC, SoilT, SWCant, SoilTant, Gness are used in SourceTerm.m.
% Xrel stores the distr. by depth of soil CO2, microb. C & root C (mgC/cm-3).
% SWC(t,z) = soil water content (m3/m3) at time t, depth z
% SoilT(t,z) = soil temp (C) at time t, depth z
% SWCant(t,z,lag) = soil water content (m3/m3) at time t - lag, depth z
% SoilTant(t,z) = soil temp (C) at time t - lag, depth z
% Gness(t,1) = Vegetation greeness at time t. 
% AtmPress(t,1) = atmostpheric pressure at the surface of PHACE.
% phig is the air filled porosity (m3/m3); phig100 is phig at -100cm H20.
% dx=[dt, dz]
% BC = [cppm, cdeep] (boundary conditions), where cppm = atmospheric [CO2]
% (or [CO2] at the soil surface) (ppm); cdeep = soil [CO2] at the bottom
% soil node (mg CO2 m-3).
% cinit(1,z) = initial conditions (soil [CO2], mg CO2 m-3) at time "zero"
% d13Cr = d13C of root-respired CO2, dim = 1xNz
% d13Cm = d13C of mirobial-respired CO2, dim = 1xNz
%
% OUTPUTS:
% out.CO2type =  is a matrix of [CO2] for every time (row), at every depth
% (col.) and CO2 type (12C-micr, 13C-micr, 12C-roots, 13C-roots).
% out.CO2 = the total [CO2], i.e. we sum across all four types.
% out.CO2fluxtype is a matrix of soil surface CO2 flux for every type (row)
% and time (col.).
% out.CO2flux = the total soil surface CO2 flux, i.e. we sum across all four types.
% out.d13C = total d13C of CO2.
% out.roots = soil surface CO2 flux from roots.

% Time step (dt) and depth increment (dz)
dt = dx(1);    % hours (hr)
dz = dx(2);    % meters (m)
% Number of time points (Nt), including initial time; and number of soil
% nodes (Nz), including surface layer (bottom boundary node is Nz+1)
[Nt Nz] = size(SWC);

%Create the phig dataset to be used when we compute the diffusion matrix 
%phig (air filled porosity) = phiT-SWC, where phiT (total soil porosity) = 1-(BD/PD)
%The value of SWC100 are estimated from fitting the water release curve function to site data of SWP.
BD=params_swp(1,:);
PD=2.52; 
SWC100=params_swp(3,:);
phiT=1-(BD./PD);  %air-filled porosity
phig=min(1,max(0,repmat(phiT,Nt,1) - SWC));  
phig100=repmat(phiT-SWC100,Nt,1);   

%Predict Diffusion at every depth & time using Moldrup's function. %Dgs0st = Diffusion 
%coefficient at standard atmosphere of temperature. T0=273.15K and pressure P0=101.3kPa.
Dg0st=repmat(0.0000139,Nt,Nz);  
T0 = 273.15;   
b=params_swp(2,:); 
P0=repmat(101.3,Nt,Nz);  %standard atmospheric pressure 
T = SoilT + 273.15;
P = repmat(AtmPress,1,Nz);  
logDg0= log(Dg0st)+(1.75*log(T/T0))+log(P0./P);
logDgs=logDg0+log((2*phig100.^3)+(0.04*phig100))+((2+(3./repmat(b,Nt,1))).*log(phig./phig100));
Dgs = exp(logDgs)*3600; % Convert Dgs above (m2 s-1) to Dgs below (m2 hr-1)
Dgs_13C = Dgs/1.0044;
Dgs_12C = Dgs;

%Upper boundary condition.  Note that we don't require a lower boundary conditions 
%because we assume dC/dz = 0 at the lower boundary (i.e. at 1m depth)  
catm = BC; % atm CO2 (ppm)
 
%We now need to compute the number of numerical time-steps needed to numerically solve the soil CO2 
%partial differential equation.  The formula given from Haberman, R. (1998). Elementary applied 
%partial differential equations (Third Edition), Prentice Hall Englewood Cliffs, NJ. (pg. 240) is
%Ndt = (dt*Dgs)/((dz^2)*0.5).  However, we need to do max(max(Dgs)) because Dgs is a matrix.  The 
%-0.05 %ensures that we have more numerical time-steps than the minimum, as a precaution.
Ndt = ceil(dt*max(max(Dgs))./((dz^2)*(0.5-0.05)));  

%Rall = Total microbial + root respiration at all depths and times. (mg C cm-3 hr-1):
%Note that Rall goes from depth z = 1cm to 100cm, so we add extra column of
%zeros (lines 91 to 93) to indicated that respiration = 0 at soil/atmosphere interface (z=0).
Rall = SourceTerm(params,params_lag,Xrel,SWC,SoilT,SWCant_Rm,SWCant_Rr,SoilTant,Gness);
R = [zeros(Nt,1) Rall.R];
Rr= [zeros(Nt,1) Rall.Rr];
Rm= [zeros(Nt,1) Rall.Rm];

% Convert to total source flux (mg CO2 m-3 hr-1) for each source and for each isotope 
% (13C and 12C): Current units for R are mg C cm-3 hr-1 per layer.  So, just need to (1) 
% convert from cm3 to m3 (mult. by 100^3); (2) convert from C to CO2 (mult. by 44/12).
S = R*(44/12)*(100^3);
Sr = Rr*(44/12)*(100^3);
Sm = Rm*(44/12)*(100^3);

%Partition the soil CO2 sources into the isotopic components:
%The lines below (115-120) are based on solving eqns (1) and (2) simultaneously for 
%[13C] (=S13root) and [12C] (=S12root):
%delta13Cr = [(Rr � Rstd)/Rstd] * 1000   ------------------- (1)
%where Rr = [13C] / [12C]
%[13C] + [12C] = Sr    ------------------------------------- (2)
%We solve for S13micr and S12micr in the same way.
%Note that the d13Cr and d13Cm refer to the isotopic signature of the
%micr. and root respiration at each depth, i.e. it's not hte isotopic
%signature of the surface respired CO2.  For the 2nd DETECT paper, we
%may wish to allow these d13Cr and d13Cm terms to vary with time (but 
%still keep fixed with depth).  
Rstd = 0.0112372;  % Rstd for 13C/12C (Pee Dee Belemite):
denomR = (1000+(1000+repmat(d13Cr,[Nt 1]))*Rstd);
denomM = (1000+(1000+repmat(d13Cm,[Nt 1]))*Rstd);
S13root = Sr.*(1000+repmat(d13Cr,[Nt 1])).*Rstd./denomR;
S12root = 1000*Sr./denomR;
S13micr = Sm.*(1000+repmat(d13Cm,[Nt 1])).*Rstd./denomM;
S12micr = 1000*Sm./denomM;
Stype(1,:,:)=S13root;
Stype(2,:,:)=S12root;
Stype(3,:,:)=S13micr;
Stype(4,:,:)=S12micr;
Stype(:,:,1)=0;

%Convert upper boundary condition (upbc) (ie atmospheric [CO2] or [CO2] at the soil
%surface) from ppm units to mg CO2 m-3 units.  Note that 101300 is the standard 
%pressure in Pa, R=8.134 is the gas constant, and the soil temp T is in Kelvin.
upbc = (catm*44/1000)*101300./(8.314*T(:,1)); 

%The Partial differential equation (equation 1 of Ryan et al., in review) is solved 
%four times for different types of soil CO2: (1) the d12C of soil CO2 from microbial 
%sources; (2) the d13C of soil CO2 from microbial sources; (3) the d12C of soil CO2 
%from root sources; (4) the d13C of soil CO2 from root sources.  This for
%loop computes the initial and boundary conditions for the four types of
%soil CO2.
cctype = ones(4,Nz+1,Nt+1)*-9999;
fluxtype=zeros(4,Nt);
for i=1:4,
    cctype(i,2:Nz,1) = (squeeze(Stype(i,1,2:Nz))'./S(1,2:Nz)).*ic(2:Nz);
    cctype(i,Nz+1,1) = cctype(i,Nz,1); %dC/dz = 0 at z=Nz means c(Nz+1,t)=c(Nz,t)
    cctype(i,1,1)=(squeeze(Stype(i,1,2))'./S(1,2)).*ic(1);
    cctype(i,1,2:(Nt+1)) = (squeeze(Stype(i,1,2))'./S(1,2)).*upbc;
end;

%Run main For Loop.  This computes the soil CO2 concentration for each of the four 
%types described above by numerically solving the partial differential equation.
ctype=zeros(4,Nz+1);
dt_old=dt;
dt = dt_old/Ndt;
for t=1:Nt_run,
    t
    if t > 1,
        for i =1:4,
            cctype(i,1,t)=(squeeze(cctype(i,2,t-1))'./sum(cctype(:,2,t-1))).*upbc(t-1);
            cctype(i,Nz+1,t)=cctype(i,Nz,t);  %dC/dz = 0 at z=Nz means c(Nz+1,t)=c(Nz,t);
        end;
    end;
    ctype = squeeze(cctype(:,:,t));
    for tt=1:Ndt,
        ctype_old = ctype;
        for z=2:Nz,
            for i=1:4,
                if ((i==1) || (i==3))
                    Dgs_t=[Dgs_13C(t,1) Dgs_13C(t,:)]; 
                else
                    Dgs_t=[Dgs_12C(t,1) Dgs_12C(t,:)];
                end
                % Numerical approximation of CO2 concentrations based on the PDE eqn in
                % Fang & Moncrieff. Numberical sol'n based on the nonhomogeneous problem 
                % in Haberman (1998) Elementary Applied Partial Differential Equations, 
                % Page 240 (section 6.3.7), aka Forward Euler method:
                if (z==Nz)
                    ctype(i,z) = ctype_old(i,z) +...
                        dt*((Dgs_t(1,z)/(dz*dz))*(ctype_old(i,z-1)-ctype_old(i,z)) +...
                        Stype(i,t,z));
                else
                    ctype(i,z) = ctype_old(i,z) +...
                        dt*((Dgs_t(1,z)/(dz*dz))*(ctype_old(i,z+1)-2*ctype_old(i,z)+ctype_old(i,z-1)) +...
                        ((Dgs_t(1,z+1)-Dgs_t(1,z-1))*(ctype_old(i,z+1)-ctype_old(i,z-1)))/(4*dz^2) +...
                        Stype(i,t,z));                    
                end
            end
        end
    end
    cctype(:,:,t+1)=[ctype(1:4,1:Nz) ctype(1:4,Nz)];
    for i=1:4,
        if ((i==1) || (i==3))
            MeanDgs=Dgs_13C(t,1);
        else
            MeanDgs=Dgs_12C(t,1);
        end
        fluxtype(i,t) = (MeanDgs*(cctype(i,2,t)-cctype(i,1,t))/dz)/(44*3.6);  
        %dividing by (44*3.6) converts units of soil CO2 from mg CO2 m-2 hr-1 to
        %umol CO2 m-2 s-1.
    end;
end;

%Store all the important outputs to 'out'.
out.CO2type = cctype;
out.CO2 = squeeze(sum(cctype,1))';
out.CO2fluxtype = fluxtype;
out.CO2flux = sum(fluxtype,1)';
out.d13C = real(squeeze((((sum(fluxtype([1 3],:),1)./sum(fluxtype([2 4],:),1))./Rstd)-1)*1000)');
out.roots = real(squeeze(sum(fluxtype(1:2,:),1)./sum(fluxtype,1))');

%Store all the less important model output as 'info'. 
info.Dgs=Dgs; info.phig=phig; info.R=R; info.S=S; 
info.Rm=Rm; info.Rr=Rr; info.Stype=Stype;