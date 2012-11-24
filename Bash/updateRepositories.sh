#bash

#Update repositories script
#Copyright (c) 2012 by seeseekey <seeseekey@gmail.com>
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.

SCRIPTPATH=$(pwd);

#Git
for directory in `find $SCRIPTPATH -name ".git" -type d`;
do
  echo $directory;
  cd $directory/..;
  git pull;
done

#Subversion
for directory in `find $SCRIPTPATH -name ".svn" -type d`;
do
  echo $directory;
  cd $directory/..;
  svn update;
done

#Pfad zurücksetzen
cd $SCRIPTPATH;