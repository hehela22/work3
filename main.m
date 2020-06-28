clc;clear;
warning off 
K_max =1; %�������

Task_period_max = 40;

% U_VEC = cell(Task_period_max,1); %ÿ���������ڣ���Դ����������VEC��Ч��
U_VEC_max = zeros(Task_period_max,1); %ÿ���������ڣ�VEC�����Ч��
P_opt = cell(Task_period_max,1); %ÿ���������ڣ�VEC����ѳ���
Resource_final = cell(Task_period_max,1); %ÿ���������ڣ�

for k=1:K_max
    
    setting;
%     [VehicleList] = Vehicle_generation();% vehicle generation,record file setup
    load('VehicleList.mat');
    time = 0;
    time_count = 0;  %���񵽴�ʱ����; %��λ:us
    Task_period = 0; %����������Ŀ������Ϊ8s
    
    Task_num = zeros(Task_period_max,1);
    Task_offload_num = zeros(Task_period_max,1);
    Success_offload_num = zeros(Task_period_max,1); 
    Success_local_num = zeros(Task_period_max,1);

    [~,Veh_num] = size(VehicleList);
    Delay_ana = zeros(Task_period_max,Veh_num);
    Delay_sim = zeros(Task_period_max,Veh_num);
    U_Vehicle = zeros(Task_period_max,Veh_num);
    Vehicle_offload_ratio = zeros(Task_period_max,Veh_num);
    
    while 1
        TimeToGo = 100; %��λ:us
        if time_count <= 0 %�����������
            Task_period = Task_period + 1;%��ʼ�µ���������
            if Task_period >  Task_period_max
                break;
            end
            VehicleList(2,:) = 0; %����ж��ָʾ����
%             [p_b_opt,p_f_opt,U_VEC_max(Task_period,1),U_VEC{Task_period,1}] = Utility_of_VEC(VehicleList);
            [p_b_opt,p_f_opt,U_VEC_max(Task_period,1),~] = Utility_of_VEC(VehicleList);
            P_opt{Task_period,1} = [p_b_opt,p_f_opt];
            for j = 1:Veh_num
                [b_j , f_j, beta_j, U_j] = Utility_of_vehicle(VehicleList, j, p_b_opt, p_f_opt);
                U_Vehicle(Task_period,j) = U_j;
                Vehicle_offload_ratio(Task_period,j) = beta_j;
                
                VehicleList(5,j) = b_j;
                VehicleList(6,j) = f_j;
                VehicleList(8,j) = min(VehicleList(7,j),(RoadLength - VehicleList(1,j))/(VehicleList(3,j)/3.6))*10^6;
                VehicleList(9,j) = beta_j * Data;
                VehicleList(10,j) = beta_j * Data;
                VehicleList(11,j) = omega * (1 - beta_j) * Data / VehicleList(4,j);
                VehicleList(12,j) = time;
                Delay_ana(Task_period,j) = VehicleList(11,j);
                
                if beta_j == 0 %���������м���ж�أ���ȫ���ؼ���
                    VehicleList(2,j) = 3;
                    if VehicleList(11,j) <= (VehicleList(8,j)/10^6) %���ؼ���ʱ��С��ʱ��Լ��
                        Success_local_num(Task_period,1) = Success_local_num(Task_period,1) + 1;
                    end                        
                end
            end
            Resource_final{Task_period,1} = VehicleList(5:6,:);
            Task_num(Task_period,1) = Task_num(Task_period,1) + Veh_num;
            Task_offload_num(Task_period,1) = Task_offload_num(Task_period,1) + sum(VehicleList(2,:)==0);
            time_count = Task_arrival_period; 
        end
        
        VehicleList = Task_exec(VehicleList,TimeToGo);
        
        time = time + TimeToGo;
        time_count = time_count - TimeToGo;
        VehicleList(8,:) = VehicleList(8,:) - TimeToGo;
        
        for j = 1:Veh_num
            if VehicleList(8,j)>=0 && VehicleList(2,j)==2
                 Delay_sim(Task_period,j) =  max(VehicleList(11,j),(time - VehicleList(12,j))/10^6);
                 Success_offload_num(Task_period,1) = Success_offload_num(Task_period,1) + 1;
                 VehicleList(2,j) = 4;
            end
        end
        
        time
        dbstop if error
        [VehicleList] = VehicleMovement(VehicleList,TimeToGo);% get vehicles new position

   end
end

