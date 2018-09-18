
if [[ ! -d downloads ]]; then
        mkdir -p downloads
        pushd downloads
	# Install Miniconda so we don't have issue between jupyter installed
	# at top-leel and also within an environment (causes problems with
	# ipywidgets.
	wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
        bash Miniconda3-latest-Linux-x86_64.sh
        echo 'export PATH=~/miniconda3/bin:$PATH' >> ~/.bashrc
        export PATH="~/miniconda3/bin:$PATH"
        popd
fi
conda create --name cs152 python=3.6
echo 'source activate cs152' >> ~/.bashrc
source activate cs152
#pip install ipykernel

#python -m ipykernel install --user --name cs152 --display-name "Python (cs152)"
conda install -c conda-forge ipywidgets
#pip install ipywidgets
#pip install jupyter
#sudo `which jupyter` nbextension enable --py widgetsnbextension --sys-prefix
#pip3 install --user wheel
#pip3 install --user setuptools
#pip install fastai
pip install --user git+git://github.com/fastai/fastai.git@cb121994872fbd5f4ee67de01bcb9848a7e54a6b
if [[ ! -d cs152 ]]; then
cd ..
  git clone https://github.com/nrhodes/cs152.git
fi
if [[ ! -d data ]]; then
  mkdir data
fi
pushd data
if [[ ! -d dogscats ]]; then
  curl http://files.fast.ai/data/dogscats.zip --output dogscats.zip
  unzip -qq dogscats.zip
  rm dogscats.zip
fi
popd

