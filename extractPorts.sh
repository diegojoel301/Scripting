echo $(cat ports | grep -oP "Host: [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sort -u); echo -n "Ports:\n"  && cat ports | grep -oP "[0-9]+/open/tcp" | sed 's/\/open//g' | sed 's/[0-9]\+/\t&/g' && cat ports | grep -oP "[0-9]+/open/tcp" | sed 's/\/open\/tcp//g' | tr '\n' ',' | sed 's/,$//g' | xclip -selection c
