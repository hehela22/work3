function  VehicleList = Task_exec(VehicleList,TimeToGo)
    setting;
    veh_num = size(VehicleList,2);
    
    for i=1:veh_num
        if VehicleList(2,i) == 0
            if VehicleList(9,i) > 0
                [VehicleList(9,i),VehicleList(2,i)] = Trans(VehicleList(:,i),TimeToGo);
            else
               if VehicleList(10,i) > 0
                   VehicleList(10,i) = Comp(VehicleList(:,i),TimeToGo);
               else
                   VehicleList(2,i) = 2;
               end
            end
        else
            continue;
        end
    end                   
end
