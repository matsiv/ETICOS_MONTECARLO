clear all
st = dbstack;
s= size(st);  %skips closing if the script has been called from another script or function 
if s(1) == 1 
close all
end
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
T = [77,300];
Waco_list = containers.Map({[1]}, {[1,1]}); %creates a dictionary for != T values
Waco_list.remove(1) %remove the initialization
Waco_list_emi = containers.Map({[1]}, {[1,1]}); %creates a dictionary for != T values
Waco_list_emi.remove(1) %remove the initialization
Waco_list_abs = containers.Map({[1]}, {[1,1]}); %creates a dictionary for != T values
Waco_list_abs.remove(1) %remove the initialization
for Ti = T
for ie = 1:nE 
    E = vE(ie);
    Waco(ie) = aco_scat_el(E,Ti); 
    Waco_list(Ti) = Waco;   %indexes by temperature
end
for ie = 1:nE 
    E = vE(ie); %loops over the points in the linespace
    [Waco_emi(ie), Waco_abs(ie)] = aco_scat(E,Ti); %returns the absorption and emission rates
    Waco_list_emi(Ti) = Waco_emi;
    Waco_list_abs(Ti) = Waco_abs;
end
end

figure(1)
Color ={"k","b","m","r","g"}
hold on
counter = 0;
for Ti = flip(T)
    col = [Color{mod(counter,5)+1}];
    counter = counter + 1;
plot(vE/Q,Waco_list_emi(Ti)+Waco_list_abs(Ti),col+"-",'DisplayName','Normal, ' + string(Ti) + 'K')
plot(vE/Q,Waco_list(Ti),col +"--", 'DisplayName','Elastic approx., ' + string(Ti) + 'K');

end
set(gca,'FontSize',14,'FontName','Arial','box','on','Yscale','log')
grid
title("Acoustic scattering rate, comparison")
legend("show")