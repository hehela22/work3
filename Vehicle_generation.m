function [VehicleList] = Vehicle_generation()

    setting;
    
%     Velocity = 100; %km/h    
    Velocity = vf*(1-VehicleDensity/kjam);
    VehNumber=ceil(VehicleDensity*RoadLength/1000);
    AvrDistance=1/VehicleDensity;
    Interdistance=random('Poisson',AvrDistance*1000,1,VehNumber+10);
    origin=0;
    num=1;
    location=[];
    while((origin+Interdistance(num))<=RoadLength)
        location(num) = origin+Interdistance(num);
        origin=origin+Interdistance(num);
        num=num+1;
    end
    
    [~,VehNumber]=size(location);
    VehicleList=zeros(13,VehNumber);
    VehicleList(1,:) = location;
    VehicleList(2,:) = 0; %VEC是否完成计算的指示变量，没计算完则为0，失败为1，成功为2; 若车辆不向MEC卸载，则为3
    VehicleList(3,:) = normrnd(Velocity,5,1,VehNumber);%车辆速度
%     VehicleList(4,:) = (0.5 + (1.5).*rand(1,VehNumber))*10^9; %车辆计算能力 单位：cycles/s
    VehicleList(4,:) = (1.5 + (0.5).*rand(1,VehNumber))*10^9; %车辆计算能力 单位：cycles/s
    VehicleList(5,:) = 0;
    VehicleList(6,:) = 0;
%     VehicleList(7,:) = 2 + 3*rand(1,VehNumber); %任务最大可容忍时延 单位:s
    VehicleList(7,:) = 3; %任务最大可容忍时延 单位:s
    VehicleList(8,:) = 0; %任务最大时延
    VehicleList(9,:) = 0; %待发送计算任务量
    VehicleList(10,:) = 0; %待VEC处理的计算任务量
    VehicleList(11,:) = 0; %本地计算时延    
    VehicleList(12,:) = 0; %任务到达时刻
    VehicleList(13,:) = 0; %任务最大时延
    
    
end
