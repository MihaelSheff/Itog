close all;
clear all;
clc;

x = [ 50.23 50.08 50.04 49.95  48 49.18 49.56 48.7997 48.75 49.23 50 49.59 49.19 49.217]; 
y = [ 12.87 14.42 15.77 16.22 14 15.479 15.96 16.80 16.75 17.36 17.81 17.25 16.607 15.867];


load('travel_data.mat');
t_max = 10000;
t_min = 0.001;
cities = 14;
s = 1:cities;
t = t_max;
alfa = 0.999;
i = 1;
while (t>t_min)
    s_c = NewState(s); 
    delta_E = Energy(s_c,distances) - Energy(s,distances);
    if delta_E<=0
        s = s_c;
    else
        P = exp(-delta_E/t);
        if rand <= P
            s=s_c;
        end
    end
    t = DecreaseTemprature(t,alfa);
    e_plot(i) = Energy(s,distances);
    i = i + 1;
end


figure;
plot(e_plot);
xlabel('Iterations');
ylabel('Energy');
grid on;

figure;
hold on
for i=1:length(x)
    k = mod(i - 1,length(x)) + 1;
    j=mod(i,length(x))+1;
    plot([x(s(k)),x(s(j))],[y(s(k)),y(s(j))],'o');
end
hold off

