#add each topic folder to fpath so that they can add functions and completion scripts
for topic_folder ($ZSH/*) if [ -d $topic_folder ]; then  fpath=($topic_folder $fpath); fi;

export PATH=$PATH:~/local_installs/bin/:~/bin
export PATH=/usr/lib64/ccache/bin:$PATH
