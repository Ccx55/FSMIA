beta0 = [0.7,0.2,1e-4,1e-3,1e-2];
lb = [0.4 0 1e-5 1e-4 1e-3];
ub = [1 0.5 1e-3 1e-2 1e-2];
opt = optimset('Display','off');
[beta,resnorm,residual,exitflag,output,lambda,jacobian] = ...
    lsqcurvefit(@csdd,beta0,X,y,lb,ub,opt);

yhat = csdd(beta,X);
semilogy(X,y,'ok',X,yhat,'r','LineWidth',3)
xlim([0 1e-2]); ylim([1e-2 1]);