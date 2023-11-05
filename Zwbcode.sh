#!/bin/bash
U_DATA="/home/SWOT/u.data"
U_ITEM="/home/SWOT/u.item"
U_USER="/home/SWOT/u.user"

g_occupation() {
  awk -F'|' 'NR==FNR && $2>=20 && $2<=29 && $4=="programmer" ;
  {prog[$1]; next} FNR!=NR && ($1 in prog) {sum[$2]+=$3; count[$2]++} END {for (m in sum) if (count[m] > 0) printf "%d %.5f\n", m, sum[m]/count[m]}';
   "$U_USER" "$U_DATA" | sort -n;
}

g_id() {
  local id=$1
  grep "^$id|" "$U_ITEM";
}

g_data() {
  awk -F'|' '{print "user", $1, "is", $2, "years old", $3, $4}';
   "$U_USER" | head -10;
}

g_movies() {
  awk -F'|' '{if ($ACTION_COLUMN == "1") print $1, $2}' "$U_ITEM" | sort -n | head -10;
}

g_user() {
  awk -F'|' -v id="$1" '$1 == id {print $2}' "$U_DATA" | sort -n | uniq;
}

g_id() {
  awk -F'|' -v id="$1" '$2 == id {sum+=$3; count++} END {if (count > 0) printf "average rating of %d: %.5f\n", id, sum/count; else print "No ratings for movie id", id;}';
   "$U_DATA";
}

di_url() {
  awk -F'|' '{ $5=""; print $0 }' "$U_ITEM" | head -10;
}

mr_date() {
  awk -F'|' 'BEGIN {OFS=FS} {split($3, date, "-"); $3 = date[3] date[2] date[1]; print}';
   "$U_ITEM" | tail -10
}


while true; do
  read -p "Enter your choice [ 1-9 ]: " choice;
  case $choice in
    1)
    read -p "Please enter the ‘user id’(1~943): " user_id;
      g_user "$user_id";
      ;;
    2)
      ACTION_COLUMN=4
      g_movies
      ;;
    3)di_url;
      ;;
      read -p "Please enter the 'movie id’(1~1682): " movie_id;
    4)
    read -p "Please enter the 'movie id’(1~1682): " movie_id;
      g_id "$movie_id";
      ;;
    5)
     echo "Bye!";
      exit 0;
      ;;
    6)
      mr_date;
      ;;
    7)
      read -p "Please enter the 'movie id’(1~1682): " movie_id;
      g_id "$movie_id";
      ;;
    8)
      g_occupation
      ;;
    9)
      g_data;
      ;;
    *)
      echo "Invalid choice, please enter 1-9.";
      ;
  esac
done


