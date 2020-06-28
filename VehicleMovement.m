function [VehicleList] = VehicleMovement(VehicleList,TimeToGo)% get vehicles new position;% new speed
% 1.location
% 2.cell
% 3.speed
% 4.QoS require
% 5.left bits
% 6.network belongings (0.none 1.BS 2.AP)
% 7.backoffvalue
% 8.backoffstage
% 9.Period
%10.Time left to change speed
%11.Price  
%12.Time left in cell 1or2
setting;
Velocity = vf*(1-VehicleDensity/kjam);
VehicleList(1,:)=VehicleList(1,:) + VehicleList(3,:)./3.6 ./10^6.*TimeToGo;

if sum(VehicleList(1,:)>RoadLength)>0
    veh_out = find(VehicleList(1,:)>RoadLength);
    veh_out_num = size(veh_out,2);
    VehicleList(1,veh_out) = mod(VehicleList(1,veh_out),RoadLength); %车辆回到小区起点
    VehicleList(3,veh_out) = normrnd(Velocity,5,1,veh_out_num);%车辆速度
    VehicleList(4,veh_out) = (1.5 + (0.5).*rand(1,veh_out_num))*10^9; %车辆计算能力
    
end

end
