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
    T = [30,77,150,300,600];
    Waco_list = containers.Map({[1]}, {[1,1]}); %creates a dictionary for != T values
    Waco_list.remove(1) %remove the initialization
    for Ti = T
    for ie = 1:nE 
        E = vE(ie);
        Waco(ie) = aco_scat_el(E,Ti); 
        Waco_list(Ti) = Waco;   %indexes by temperature
    end
    end
    if isKey(Waco_list,77) && isKey(Waco_list,300) %check if the keys exist
    figure(1)
    semilogy(vE/Q,Waco_list(300),'r-',vE/Q,Waco_list(77),'b-','linewidth',2);
    set(gca,'FontSize',14,'FontName','Arial','box','on')
    ylabel('Acoustic scattering rate, 1/s')
    xlabel('Energy, eV')
    title("Acoustic scattering rate, elastic approx")
    grid on
    legend('T=300K','T=77K')
    end
    figure(2)
    hold on
    for Ti = flip(T)
    plot(vE/Q,Waco_list(Ti),'linewidth',2, 'DisplayName','T=' + string(Ti) + 'K');
    end
    set(gca,'FontSize',14,'FontName','Arial','box','on','Yscale','log')
    ylabel('Acoustic scattering rate, 1/s')
    xlabel('Energy, eV')
    title("Acoustic scattering rate, elastic approx")
    grid on
    legend('show')
    hold off=300;
for ie = 1:nE 
    E = vE(ie);
    Waco300(ie) = aco_scat_el(E,T); 
end
T=77;
for ie = 1:nE 
    E = vE(ie);
    Waco77(ie) = aco_scat_el(E,T); 
end
%
figure(1)
semilogy(vE/Q,Waco300,'r-',vE/Q,Waco77,'b-','linewidth',2);
set(gca,'FontSize',14,'FontName','Arial','box','on')
ylabel('Acoustic scattering rate, 1/s')
xlabel('Energy, eV')
grid on
legend('T=300K','T=77K')
