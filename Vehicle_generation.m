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
    VehicleList(2,:) = 0; %VEC�Ƿ���ɼ����ָʾ������û��������Ϊ0��ʧ��Ϊ1���ɹ�Ϊ2; ����������MECж�أ���Ϊ3
    VehicleList(3,:) = normrnd(Velocity,5,1,VehNumber);%�����ٶ�
%     VehicleList(4,:) = (0.5 + (1.5).*rand(1,VehNumber))*10^9; %������������ ��λ��cycles/s
    VehicleList(4,:) = (1.5 + (0.5).*rand(1,VehNumber))*10^9; %������������ ��λ��cycles/s
    VehicleList(5,:) = 0;
    VehicleList(6,:) = 0;
%     VehicleList(7,:) = 2 + 3*rand(1,VehNumber); %������������ʱ�� ��λ:s
    VehicleList(7,:) = 3; %������������ʱ�� ��λ:s
    VehicleList(8,:) = 0; %�������ʱ��
    VehicleList(9,:) = 0; %�����ͼ���������
    VehicleList(10,:) = 0; %��VEC����ļ���������
    VehicleList(11,:) = 0; %���ؼ���ʱ��    
    VehicleList(12,:) = 0; %���񵽴�ʱ��
    VehicleList(13,:) = 0; %�������ʱ��
    
    
end
