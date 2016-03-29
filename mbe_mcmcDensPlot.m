function mbe_mcmcDensPlot(mcmcParam)
%% mbe_mcmcDensPlot
% Plots probability density function MCMC chains of one parameter.
% Also shows the HDI of the parameter for every chain.
%
% INPUT:
%   mcmcParam
%       2d matrix with MCMC parameter as column vector for every chain
%
% EXAMPLE:
%   mbe_mcmcDensPlot(mcmcParam);

% Nils Winter (nils.winter1@gmail.com)
% Johann-Wolfgang-Goethe University, Frankfurt
% Created: 2016-03-22
% Version: v1.1
%-------------------------------------------------------------------------
nChain = size(mcmcParam,2);
cc='rgbcy';
for indChain = 1:nChain
    [F,XI] = ksdensity(mcmcParam(:,indChain));
    plot(XI,F,'Color',cc(indChain));
    hold on;
    hdiLim = HDIofMCMC(mcmcParam(:,indChain),.95);
    plot([hdiLim(1) hdiLim(1)],[0 0.1],'Color',cc(indChain));
    plot([hdiLim(2) hdiLim(2)],[0 0.1],'Color',cc(indChain));
end
xlabel('Param. Value'); ylabel('Density');
text(mean(hdiLim(:)),0.1,'95% HDI');

% Display MCSE
[~,neff,~,~,~,~,~] = psrf(mcmcParam);
MCSE = std(mcmcParam(:))/sqrt(sum(neff(:)));
str = ['MCSE: ' num2str(MCSE,'%.5f')];
xLim = xlim;
yLim = ylim;
x = mean(xLim(:)) + (xLim(2)-xLim(1)) * 0.07;
y = mean(yLim(:)) + (yLim(2)-yLim(1)) * 0.2;
t = text(x,y,str);
set(t,'FontSize',12);
end