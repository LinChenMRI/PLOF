function SaveEps(dir,name)

mymkdir(dir);
saveas(gcf,[dir,filesep,name,'.eps'],'epsc');
saveas(gcf,[dir,filesep,name,'.emf'],'meta');
saveas(gcf,[dir,filesep,name,'.bmp'],'bmp');
saveas(gcf,[dir,filesep,name,'.fig'],'fig');
saveas(gcf,[dir,filesep,name,'.tif'],'tiff');
saveas(gcf,[dir,filesep,name,'.pdf'],'pdf');

end