#!/bin/sh

fighterPath(){
	echo "You chose the fighter path"

	userWeapon=""
	fighterWeapon=("Sword" "Spear" "Axe")
	
	select weapon in "${fighterWeapon[@]}"
	do
		case $weapon in 
			"Sword")
				userWeapon="Sword"
				echo "You chose a sword"
				break
			;;
			"Spear")
				userWeapon="Spear"
				echo "You chose a spear"
				break
			;;
			"Axe")
				userWeapon="Axe"
				echo "You chose an axe"
				break
			;;
			*) 
				echo "Invalid option, choose again"
			;;
		esac
	done

	Mob=("Bear" "Tiger" "Brian Crites")
	
	select mob in "${Mob[@]}"
	do 	
		case $mob in
			"Bear")
				echo "You win, the end"
				break
			;;
			"Tiger")
				echo "You win, the end"
				break
			;;
			"Brian Crites")	
				echo "You lose, the end"
				break
			;;
			*) 
				echo "Invalid option, choose again"
			;;
		esac
	done	
}

magePath(){
	echo "You chose the mage path"
        userWeapon=""
        mageWeapon=("Staff" "Wand" "Ring")

        select weapon in "${mageWeapon[@]}"
        do
                case $weapon in
                        "Staff")
                                userWeapon="Staff"
                                echo "You chose a Staff"
                                break
                        ;;
                        "Wand")
                                userWeapon="Wand"
                                echo "You chose a Wand"
                                break
                        ;;
                        "Ring")
                                userWeapon="Ring"
                                echo "You chose an Ring"
                                break
                        ;;
                        *)
                                echo "Invalid option, choose again"
                        ;;
                esac
        done
        Mob=("Bear" "Tiger" "Brian Crites")

        select mob in "${Mob[@]}"
        do      
                case $mob in   
                        "Bear")
                                echo "You win, the end"
                                break
                        ;;
                        "Tiger")
                                echo "You win, the end"
                                break
                        ;;
                        "Brian Crites") 
                                echo "You win, the end"
                                break
                        ;;
                        *) 
                                echo "Invalid option, choose again"
                        ;;
                esac
        done
}

archerPath(){
	echo "You chose the archer path"
       	userWeapon=""
        archerWeapon=("Bow" "Crossbow" "Throwing Knife")

        select weapon in "${archerWeapon[@]}"
        do
                case $weapon in
                        "Bow")
                                userWeapon="Bow"
                                echo "You chose a Bow"
                                break
                        ;;
                        "Crossbow")
                                userWeapon="Crossbow"
                                echo "You chose a Crossbow"
                                break
                        ;;
                        "Throwing Knife")
                                userWeapon="Throwing Knife"
                                echo "You chose a Throwing Knife"
                                break
                        ;;
                        *)
                                echo "Invalid option, choose again"
                        ;;
                esac
        done

        Mob=("Bear" "Tiger" "Brian Crites")

        select mob in "${Mob[@]}"
        do      
                case $mob in   
                        "Bear")
                                echo "You lose, the end"
                                break
                        ;;
                        "Tiger")
                                echo "You lose, the end"
                                break
                        ;;
                        "Brian Crites") 
                                echo "You lose, the end"
                                break
                        ;;
                        *) 
                                echo "Invalid option, choose again"
                        ;;
                esac
        done
}

llamaPath(){
	echo "You chose the llama path"
        userWeapon=""
        llamaWeapon=("nothing" "nothing" "nothing")

        select weapon in "${llamaWeapon[@]}"
        do
                case $weapon in
                        "nothing")
				userWeapon="nothing"
				echo "You are still a llama"
				break
			;;
                        *)
                                echo "Invalid option, choose again"
                        ;;
                esac
        done	
	
	Mob=("Brian Crites" "Brian Crites" "Brian Crites")

        select mob in "${Mob[@]}"
        do      
                case $mob in   
                        "Brian Crites") 
                                echo "You never win against Brian Crites"
                                break
                        ;;
                        *) 
                                echo "Invalid option, choose again"
                        ;;
                esac
        done
}

genderOptions=("Boy" "Girl")
userGender=""

select gender in ${genderOptions[@]}
do
	case $gender in
		"Boy")
			userGender="Boy"
			break
		;;
		"Girl")
			userGender="Girl"
			break
		;;
		*)
			echo "Invalid option, choose again"
		;;
	esac
done
						

ClassOptions=("Fighter" "Mage" "Archer" "Llama")
userClass=""

select class in "${ClassOptions[@]}"
do 
	case $class in 
		"${ClassOptions[0]}")
			userClass="${ClassOptions[0]}"
			break
		;;
		"${ClassOptions[1]}")
			userClass="${ClassOptions[1]}"
			break
		;;
		"${ClassOptions[2]}")
			userClass="${ClassOptions[2]}"
			break
		;;
		"${ClassOptions[3]}")
			userClass="${ClassOptions[3]}"
			break
		;;
		*)
			echo "invalid option, please choose again"
		;;
	esac
done

if [ $userClass = "Fighter" ]; then
	if [ $userGender = "Girl" ]; then
		echo "Fighters can only be boys"
	else
		fighterPath
	fi
elif [ $userClass = "Mage" ]; then
	if [ $userGender = "Boy" ]; then
		echo "Mages can only be girls"
	else
		magePath
	fi
elif [ $userClass = "Archer" ]; then
	archerPath
else 
	llamaPath

fi
