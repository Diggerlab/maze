#! /bin/sh
#=============================================================================
#     FileName: deploy.sh
#         Desc: 
#       Author: Hector
#        Email: myourys@gmail.com
#     HomePage: http://www.yiwuye.com
#      Version: 0.0.1
#   LastChange: 2014-09-03 16:11:00
#      History:
#=============================================================================

#Current Path
pathCur=$(pwd)

#maze-design Path
pathDesign=$pathCur
if [ ! -d $p ]
then
    pathDesign=$pathCur
fi

#Maze Resources Path
pathRes=$pathDesign/../Resources


########  Copy Design  ###############
function copyRes()
{
    cp -r $pathDesign/maze-ccs/Resources/data $pathRes/
    cp -r $pathDesign/maze-ccs/Resources/publish $pathRes

    cp $pathDesign/maze-ccs/CocoStudio/assets/publish/*.plist $pathRes/publish/

    #rsync -av $pathDesign/Icon/iOS/ "$pathRes/../proj.ios_mac/Poodle iOS/Images.xcassets/AppIcon.appiconset/"
    rsync -av $pathDesign/Splash/iOS/ "$pathRes/../proj.ios_mac/Maze iOS/Images.xcassets/LaunchImage.launchimage/"

    #cp -r -f $pathDesign/Icon/V3/Android/ "$pathRes/../proj.android/res/"
    #cp -f $pathDesign/Splash/V3/Android/* "$pathRes/../proj.android/res/drawable/"

    find maze-ccs/CocoStudio/assets/animation -name "opening" |awk \
        '{ printf "mkdir -p %s\n",$1}'|sed    \
        's/maze-ccs\/CocoStudio\/assets\/animation/tmp/'|sh

    find maze-ccs/CocoStudio/assets/animation -name "opening" |awk \
        '{ printf "cp -f %s/* t%s\n",$1,$1}'|sed  \
        's/tmaze-ccs\/CocoStudio\/assets\/animation/tmp/'|sh

    cp -r -f tmp/* $pathRes/opening
    rm -r tmp
}


cd $pathDesign

git pull origin master

copyRes

cd $pathCur
