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
end