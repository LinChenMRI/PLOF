function mymkdir(datadir)

if exist(datadir,'file')==0
    mkdir(datadir);
end
end