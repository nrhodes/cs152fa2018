if [[ ! -d downloads ]]; then
        mkdir -p downloads
        wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
        bash Anaconda3-5.0.1-Linux-x86_64.sh -b
        echo 'export PATH=~/anaconda3/bin:$PATH' >> ~/.bashrc
fi
source ~/.bashrc
conda create --name cs152 python=3.6
source activate cs152
pip install ipykernel
 
python -m ipykernel install --user --name cs152 --display-name "Python (cs152)"
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
cd data
if [[ ! -d dogscats ]]; then
  curl http://files.fast.ai/data/dogscats.zip --output dogscats.zip
  unzip -qq dogscats.zip
  rm dogscats.zip
fi
cd ..

