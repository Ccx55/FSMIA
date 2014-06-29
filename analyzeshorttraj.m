function newTraj = analyzeshorttraj(Molecule,trajAll,Option)
% find all short trajectories with molecule located in the same imageJ
% coordinates
% Approximate run time: 70 min
% Input:
% Molecule: same as the result obtained previously
% trajAll = Result.Trajectory;
% Option: previous Option in analysis
% set Option.imSize = 512 before use this function

nTraj = length(trajAll);
imSize = Option.imSize(1);
trajStat = struct('x',0,'y',0,'n',0,'traj',{});
formatSpec = '%d,';
for i = 1:imSize
    for j = 1:imSize
        ind = (i-1)*imSize+j;
        trajStat(ind).x = i;
        trajStat(ind).y = j;
        shortTrajInd = 1;
        for k = 1:nTraj
            molIndex = trajAll(k).trajectory(1);
            coordinates = Molecule(molIndex).coordinate(3:4);
            if coordinates(1)==i && coordinates(2)==j
                trajStat(ind).traj{shortTrajInd} = num2str(trajAll(k).trajectory,formatSpec);
                shortTrajInd = shortTrajInd+1;
            end
        end
        trajStat(ind).n = length(trajStat(ind).traj);
    end
end

%{
% write the short trajectory data to file
fileID = fopen('result.txt','w');
fprintf(fileID,'x\ty\tn\ttrajectory\n');
for i = 1:(imSize^2)
    n = trajStat(i).n;
    if n
        fprintf(fileID,'%d\t%d\t%d\t%s\n',[trajStat(i).x,trajStat(i).y,trajStat(i).n,...
            strjoin(trajStat(i).traj,'|')]);
    end
end
fclose(fileID);
%}

newTraj = struct('trajectory',[]);
ind_newtraj = 1;
% connect short trajectories into a single long trajectory
for i = 1:(imSize^2)
    if trajStat(i).n == 0
        continue
    end
    molInd = cell(1);
    for k = 1:trajStat(i).n
        molInd{k} = str2num(trajStat(i).traj{k});
    end
    % avoid duplicate counting
    trajStat(i).n = 0;
    
    for j = (i+1):(imSize^2)
        if trajStat(j).n ~=0 && isneighbor(trajStat(i),trajStat(j))
           fprintf('%d\n',j);
           for k = 1:trajStat(j).n
               molInd{length(molInd)+1} = str2num(trajStat(j).traj{k});
           end
           trajStat(j).n = 0;
        end
    end
    n_traj = length(molInd);
    first_mol_ind = zeros(1,n_traj);
    for k = 1:n_traj
        first_mol_ind(k) = molInd{k}(1);
    end
    [~,ind_sort] = sort(first_mol_ind);
    molInd = molInd(ind_sort);
    traj_complete = molInd{1};
    for k = 2:n_traj
        end_mol_ind = traj_complete(end);
        start_mol_ind = molInd{k}(1);
        n_gap = Molecule(start_mol_ind).frame - Molecule(end_mol_ind).frame - 1;
        traj_complete = [traj_complete,NaN(1,n_gap),molInd{k}];
    end
    newTraj(ind_newtraj).trajectory = traj_complete;
    ind_newtraj = ind_newtraj + 1;
    fprintf('%d\n',ind_newtraj);
end


function val = isneighbor(trajStat_1,trajStat_2)
    if abs(trajStat_1.x - trajStat_2.x)<=1 && abs(trajStat_1.y - trajStat_2.y)<=1
        val = true;
    else
        val = false;
    end
end

end