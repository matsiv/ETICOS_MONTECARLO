function[Waco_emi,Waco_abs]=aco_scat(E,T)

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

Es=(meff*v_l^2)/2;
C=4*sqrt(Es)/(kB*T*(1-4*alpha*Es));
gamma=E*(1+alpha*E);

if gamma<Es/(1-4*alpha*Es)
x1a=C*(sqrt(Es)*2*alpha*E-sqrt(gamma));
x2a=C*(sqrt(Es)*2*alpha*E+sqrt(gamma));
x1e=0;
x2e=0;
else 
x1a=0;
x2a=C*(sqrt(Es)*2*alpha*E+sqrt(gamma));
x1e=0;
x2e=C*(sqrt(gamma)-sqrt(Es)*(1+2*alpha*E));
end
Waco_abs=(1+2*alpha*E)*((x2a^12/574801920 - x2a^10/12096000 + x2a^8/241920 - x2a^6/4320 + x2a^4/48 - x2a^3/6 + x2a^2/2)+...
-(x1a^12/574801920 - x1a^10/12096000 + x1a^8/241920 - x1a^6/4320 + x1a^4/48 - x1a^3/6 + x1a^2/2))+...
+2*alpha*kB*T*((x2a^3*(5*x2a^10 - 234*x2a^8 + 11440*x2a^6 - 617760*x2a^4 + 51891840*x2a^2 - 389188800*x2a + 1037836800))/3113510400+...
-(x1a^3*(5*x1a^10 - 234*x1a^8 + 11440*x1a^6 - 617760*x1a^4 + 51891840*x1a^2 - 389188800*x1a + 1037836800))/3113510400);
Waco_abs=Waco_abs*(sqrt(meff)*(kB*T)^3*Daco^2)/(2^(5/2)*pi*HBAR^4*v_l^4*rho*sqrt(gamma));

Waco_emi=(1+2*alpha*E)*((x2e^12/574801920 - x2e^10/12096000 + x2e^8/241920 - x2e^6/4320 + x2e^4/48 + x2e^3/6 + x2e^2/2)+...
    -(-x1e^12/574801920 - x1e^10/12096000 + x1e^8/241920 - x1e^6/4320 + x1e^4/48 + x1e^3/6 + x1e^2/2))+...
    -2*alpha*kB*T*((x2e^3*(5*x2e^10 - 234*x2e^8 + 11440*x2e^6 - 617760*x2e^4 + 51891840*x2e^2 + 389188800*x2e + 1037836800))/3113510400+...
    -(x1e^3*(5*x1e^10 - 234*x1e^8 + 11440*x1e^6 - 617760*x1e^4 + 51891840*x1e^2 + 389188800*x1e + 1037836800))/3113510400);
Waco_emi=Waco_emi*(sqrt(meff)*(kB*T)^3*Daco^2)/(2^(5/2)*pi*HBAR^4*v_l^4*rho*sqrt(gamma));