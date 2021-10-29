#!/bin/sh

SODA_BASE_PRICE=100
payment=0
balance=0

price_variance=$(( ($RANDOM%7-3)*5 ))
soda_price=$((SODA_BASE_PRICE+$price_variance))
balance=$((soda_price-$payment))

clear
echo "Welcome to the soda machine.  You can enter values of 5, 10 or 25 in payment." 
echo
read -p "What type of soda would you like? " soda_type
echo
echo "The current price of $soda_type is $soda_price cents"
echo

while true;
do
	read -p "Enter a coin: " coin
	if [[ $coin -eq 5 ]]; then
		echo "You have inserted a nickel."
	elif [[ $coin -eq 10 ]]; then
		echo "You have inserted a dime."
	elif [[ $coin -eq 25 ]]; then
		echo "You have inserted a quarter."
	else
		echo "That is not a valid amount."
		echo "You still owe $balance cents."
		echo
		continue
	fi


	payment=$(($payment + $coin))
	balance=$(($soda_price - $payment))

	if [[ $balance -gt 0 ]]; then
		echo "You still owe $balance cents."
		echo
	elif [[ $balance -lt 0 ]]; then
		refund=$(($balance * -1))
		echo
		echo "You have been refunded $refund cents."
		break
	else
		break
	fi

done

echo
echo "Your $soda_type is being dispensed.  Thank you!"
echo
read -p "Press the enter key to close the script"
clear
