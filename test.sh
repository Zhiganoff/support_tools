#!/bin/bash

# Цвет текста:
NORMAL='\033[0m'      #  ${NORMAL}    # все атрибуты по умолчанию
RED='\033[0;31m'         #  ${RED}
GREEN='\033[0;32m'      #  ${GREEN}
BLUE='\033[0;36m'     #  ${BLUE}

# Цветом текста (жирным) (bold) :
DEF='\033[0;39m'       #  ${DEF}
DGRAY='\033[1;30m'     #  ${DGRAY}
LRED='\033[1;31m'       #  ${LRED}
LGREEN='\033[1;32m'     #  ${LGREEN}
LYELLOW='\033[1;33m'     #  ${LYELLOW}
LBLUE='\033[1;34m'     #  ${LBLUE}
LMAGENTA='\033[1;35m'   #  ${LMAGENTA}
LCYAN='\033[1;36m'     #  ${LCYAN}
WHITE='\033[1;37m'     #  ${WHITE}

# Цвет фона
BGBLACK='\033[40m'     #  ${BGBLACK}
BGRED='\033[41m'       #  ${BGRED}
BGGREEN='\033[42m'     #  ${BGGREEN}
BGBROWN='\033[43m'     #  ${BGBROWN}
BGBLUE='\033[44m'     #  ${BGBLUE}
BGMAGENTA='\033[45m'     #  ${BGMAGENTA}
BGCYAN='\033[46m'     #  ${BGCYAN}
BGGRAY='\033[47m'     #  ${BGGRAY}
BGDEF='\033[49m'      #  ${BGDEF}


# Дополнительные свойства для текта:
BOLD='\033[1m'       #  ${BOLD}      # жирный шрифт (интенсивный цвет)
DBOLD='\033[2m'      #  ${DBOLD}    # полу яркий цвет (тёмно-серый, независимо от цвета)
NBOLD='\033[22m'      #  ${NBOLD}    # установить нормальную интенсивность
UNDERLINE='\033[4m'     #  ${UNDERLINE}  # подчеркивание
NUNDERLINE='\033[4m'     #  ${NUNDERLINE}  # отменить подчеркивание
BLINK='\033[5m'       #  ${BLINK}    # мигающий
NBLINK='\033[5m'       #  ${NBLINK}    # отменить мигание
INVERSE='\033[7m'     #  ${INVERSE}    # реверсия (знаки приобретают цвет фона, а фон -- цвет знаков)
NINVERSE='\033[7m'     #  ${NINVERSE}    # отменить реверсию
BREAK='\033[m'       #  ${BREAK}    # все атрибуты по умолчанию
NORMAL='\033[0m'      #  ${NORMAL}    # все атрибуты по умолчанию

clear

problem="${1^}"

if g++ -std=c++11 -O2 -o res $1.cpp
    then
        cnt=0
        ok=0
        test_n=1
        echo -e "${BGBLUE}${UNDERLINE}Problem $problem\n${NORMAL}"
        while [ -f tests/$problem/case$test_n.in ]
        do
            input=`cat tests/$problem/case$test_n.in`
            if [[ $input == "" ]]; then
                let test_n=$test_n+1
                continue
            fi
            author_output=`cat tests/$problem/case$test_n.out`
            my_output=`./res < tests/$problem/case$test_n.in`
            echo -e "${LMAGENTA}Test $test_n:\n${NORMAL}$input\n${GREEN}Execution output:${NORMAL}\n$my_output"
            if [ "$my_output" == "$author_output" ]
            then
                echo -e "${LGREEN}OK${NORMAL}"
                let ok=$ok+1
            else
                echo -e "${LRED}WA\n${LYELLOW}Expected output:${NORMAL}\n$author_output"
            fi
            let cnt=$cnt+1
            let test_n=$test_n+1
            echo
        done
        if [ $cnt -eq $ok ]
        then
            echo -e "${LGREEN}Success${NORMAL}"
        else
            dif=$(($cnt-$ok))
            echo -e "${LRED}Error:${NORMAL} passed ${LRED}$ok/$cnt${NORMAL} tests"
        fi
    else
        echo "Failed to compile"
fi

exit 0
