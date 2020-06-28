%public setting

% SimulationTime=100*10^6; %simulation duration 

Task_arrival_period = 8*10^6; %��λ:us ���񵽴�ʱ����

VehicleDensity = 60 ;% veh/km

kjam=250;%veh/km

vf=120;%km/h  



Radius = 200; %meter RSU���Ƿ�Χ�뾶

d_r = 100; %meter RSU��·�߾���

RoadLength=2*sqrt(Radius^2-(d_r)^2);%meter RSU����С������



Noise = -100; % �������� ��λ��dbm

P_n = 10^(Noise/10); %�������� ��λ��mW

P_t = 500; % �������书�� ��λ��mW

P_loss = 3; % ��߶�˥��ϵ�� 



Alpha = 20;

Data = 5*10^6; %������������bit

F = 20*10^9;%VEC��������ʼ������Դ����Hz

B = 20*10^6;%VEC��������ʼ������Դ����Hz

omega = 1000;%������������CPU������Ŀ

c_b = 2*1e-6;%��λ������Դ�۸�

c_f = 5*1e-10;%��λ������Դ�۸�

Delta_b = 5*1e-7;%�۸񲽳�

Delta_f = 5*1e-10;%�۸񲽳�

p_b_max = 1e-5;%��λ������Դ���۸�

p_f_max = 1e-8;%��λ������Դ���۸�




