setupName=$(git config --local remote.origin.url|sed -n 's#.*/\([^.]*\)\.git#\1#p')
conda_build "./anaconda_build/$setupName"
conda install --use-local $setupName
