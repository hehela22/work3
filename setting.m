%public setting

% SimulationTime=100*10^6; %simulation duration 

Task_arrival_period = 8*10^6; %单位:us 任务到达时间间隔

VehicleDensity = 60 ;% veh/km

kjam=250;%veh/km

vf=120;%km/h  



Radius = 200; %meter RSU覆盖范围半径

d_r = 100; %meter RSU到路边距离

RoadLength=2*sqrt(Radius^2-(d_r)^2);%meter RSU覆盖小区长度



Noise = -100; % 噪声功率 单位：dbm

P_n = 10^(Noise/10); %噪声功率 单位：mW

P_t = 500; % 车辆传输功率 单位：mW

P_loss = 3; % 大尺度衰落系数 



Alpha = 20;

Data = 5*10^6; %计算任务量：bit

F = 20*10^9;%VEC服务器初始计算资源量：Hz

B = 20*10^6;%VEC服务器初始带宽资源量：Hz

omega = 1000;%比特任务所需CPU周期数目

c_b = 2*1e-6;%单位带宽资源价格

c_f = 5*1e-10;%单位计算资源价格

Delta_b = 5*1e-7;%价格步长

Delta_f = 5*1e-10;%价格步长

p_b_max = 1e-5;%单位带宽资源最大价格

p_f_max = 1e-8;%单位计算资源最大价格




