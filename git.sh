if [ $1 == 'lab' ]
then
   git push -u origin master
elif [ $1 == 'hub' ]
then
   git push --mirror github
elif [ $1 == 'inithub' ]
then
 	git remote add github https://github.com/jayant-sharma/matrix.git
	echo "github remote added"
elif [ $1 == 'initlab' ]
then
	git remote add origin https://gitlab.com/eda-developers/matrix.git
	echo "gitlab remote added"
elif [ $1 == 'seturl' ]
then
	git remote set-url origin https://gitlab.com/eda-developers/matrix.git
	git remote set-url origin https://github.com/jayant-sharma/matrix.git
else
   echo "No git repository mentioned!"
fi


