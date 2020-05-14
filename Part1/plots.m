clear all
close all

c_light = 2.99792458e+8; % light velocity, m/s
H = 6.626070040e-34; % Planck constant, J*s
HBAR = 1.054D-34; % reduced Planck constant, J*s
kB = 1.3806488e-23; % Boltzmann constant, J/K
Q = 1.6021766208e-19; % elementary charge, C
eps0 = 8.854D-12; % vacuum permittivity constant, F/m
M0 = 9.1095D-31; % electron mass, kg
%
rho = 5320; % mass density, kg/m?3
eps_s = 12.9*eps0; % static dielectric constant, F/m
eps_infty = 10.9*eps0; % high-frequency dielectric constant, F/m
v_l = 5240; % longitudinal sound velocity, m/s
meff = 0.067*M0; % effective mass, kg
alpha = 0.64/Q; % nonparabolicity factor, 1/J
hwpop = 0.0354*Q; % longitudinal optical phonon energy, J
Daco = 7*Q; % acoustic deformation potential, J
egap = 1.424*Q; % energy gap, J

z = sym('z','real');
x = sym('x','real');

nE = 200; % number of energy points
vE = linspace(0,1,nE)*Q; % energy axis, J
T=300;
for ie = 1:nE 
    E = vE(ie);
    [Waco_emi300(ie), Waco_abs300(ie)] = aco_scat(E,T); 
end

T=77;
for ie = 1:nE 
    E = vE(ie);
    [Waco_emi77(ie), Waco_abs77(ie)] = aco_scat(E,T); 
end

figure(1)
semilogy(vE/Q,Waco_emi300,'r-',vE/Q,Waco_abs300,'b-',vE/Q,Waco_emi300+Waco_abs300,'k-',vE/Q,Waco_emi77,'r--',vE/Q,Waco_abs77,'b--',vE/Q,Waco_emi77+Waco_abs77,'k--')
set(gca,'FontSize',14,'FontName','Arial','box','on')
grid
ylabel('Acoustic scattering rate, 1/s')
xlabel('Energy, eV')
legend('emission at 300K','absorption at 300K','total at 300K', 'emission at 77K', 'absorption at 77K','total at 77K');
% 