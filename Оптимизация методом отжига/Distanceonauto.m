close all;
clear all;
clc;
    x = [26.42 28.11 28.46 25.39 21.35 26.56 24.57 22.16];   
    y = [60.52 61.03 61.11 60.59 61.30 60.28 60.10 60.27]; 
load('Goroda.mat');
t_max = 53423;
t_min = 0.001;
cities = 8;
s = 1:cities;
t = t_max;
alfa = 0.999;
i = 1;

while (t>t_min)
    s_c = NewState(s); 
    delta_E = Energy(s_c,Goroda) - Energy(s,Goroda);
    if delta_E<=0
        s = s_c;
    else
        P = exp(-delta_E/t);
        if rand <= P
            s=s_c;
        end
    end
    t = DecreaseTemprature(t,alfa);
    e_plot(i) = Energy(s,Goroda);
    i = i + 1;
end
figure;
plot(e_plot,'r');
    title('Зависимость энергии от номера итерации');
    grid('on');
    xlabel('Номер итерации');
    ylabel('Энергия');

figure;
hold on
for i=1:length(x)
    k = mod(i - 1,length(x)) + 1;
    j=mod(i,length(x))+1;
    plot([x(s(k)),x(s(j))],[y(s(k)),y(s(j))],'m'); %график оптимизированного маршрута
        title('Маршрут "Расстояние"');
        grid('on');
        xlabel('Долгота'); 
        ylabel('Широта'); 
        text(26.42,60.52,'Коувала');
        text(28.11,61.03,'Лаппенранта');
        text(28.46,61.11,'Иматра');
        text(25.39,60.59,'Лахти');
        text(21.35,61.30,'Тампере');
        text(26.56,60.28,'Котка');
        text(24.57,60.10,'Хельсинки');
        text(22.16,60.27,'Турку');
end
hold off

%график неоптимизированного маршрута

% figure;
% hold on
% for i=1:length(x)
%     k = mod(i - 1,length(x)) + 1;
%     j=mod(i,length(x))+1;
%     plot([x(k),x(j)],[y(k),y(j)],'r');%график неоптимизированного маршрута
%         title('Маршрут "Расстояние"');
%         grid('on');
%         xlabel('Долгота'); 
%         ylabel('Широта'); 
%         text(26.42,60.52,'Коувала');
%         text(28.11,61.03,'Лаппенранта');
%         text(28.46,61.11,'Иматра');
%         text(25.39,60.59,'Лахти');
%         text(21.35,61.30,'Тампере');
%         text(26.56,60.28,'Котка');
%         text(24.57,60.10,'Хельсинки');
%         text(22.16,60.27,'Турку');
% end
% hold off
