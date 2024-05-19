#!/bin/sh
ra_profileResponse=$(curl -s "https://retroachievements.org/API/API_GetUserProfile.php?u=CryZo&y=$RA_KEY")
ra_RichPresenceMsg=$(echo "$ra_profileResponse" | jq -r .RichPresenceMsg)
ra_LastGameID=$(echo "$ra_profileResponse" | jq -r .LastGameID)
ra_TotalPoints=$(echo "$ra_profileResponse" | jq -r .TotalPoints)
ra_User=$(echo "$ra_profileResponse" | jq -r .User)

ra_lastGameResponse=$(curl -s "https://retroachievements.org/API/API_GetGame.php?i=$ra_LastGameID&y=$RA_KEY")
ra_LastGameTitle=$(echo "$ra_lastGameResponse" | jq -r .GameTitle)
ra_LastGameImageBoxArt=$(echo "$ra_lastGameResponse" | jq -r .ImageBoxArt)

echo '<p align="center">' > README.md
echo '<img src="header.png">' >> README.md
echo '</p>' >> README.md
echo '' >> README.md

# Badge bar
echo -n "<img src=\"https://api.visitorbadge.io/api/combined?path=https%3A%2F%2Fgithub.com%2FCryZo&label=Profile%20views%20(total%20%2F%20today)&countColor=%23ba68c8&style=flat\" />" >> README.md
echo -n "<a href=\"https://retroachievements.org/user/$ra_User\"><img src=\"https://img.shields.io/badge/Retro_Archievements-$ra_TotalPoints-00C647\" /></a>" >> README.md
echo -n "<img src=\"https://img.shields.io/badge/TypeScript-3370B3\" />" >> README.md
echo -n "<img src=\"https://img.shields.io/badge/Tailwind_CSS-35BEF8\" />" >> README.md
echo -n "<img src=\"https://img.shields.io/badge/Vue.js-3AA676\" />" >> README.md
echo -n "<img src=\"https://img.shields.io/badge/I_hate-WordPress-white?labelColor=ffffff&color=21759A\" />" >> README.md

echo '' >> README.md
echo '# Last contributions' >> README.md
echo '<picture>' >> README.md
echo '  <source media="(prefers-color-scheme: dark)" srcset="dist/github-snake-dark.svg" />' >> README.md
echo '  <source media="(prefers-color-scheme: light)" srcset="dist/github-snake.svg" />' >> README.md
echo '  <img alt="github-snake" src="dist/github-snake.svg" />' >> README.md
echo '</picture>' >> README.md

echo '' >> README.md

echo '# Retroarchievements' >> README.md
echo '## Last Played' >> README.md
echo '<p align="center">' >> README.md
echo "<img alt='$ra_LastGameTitle' src='https://retroachievements.org$ra_LastGameImageBoxArt'>" >> README.md
echo '</p>' >> README.md
echo '' >> README.md
echo "**$ra_LastGameTitle**" >> README.md
echo "> $ra_RichPresenceMsg" >> README.md

ra_latestArchievementsResponse=$(curl -s "https://retroachievements.org/API/API_GetUserRecentAchievements.php?u=CryZo&y=$RA_KEY&m=43200")
echo '## Latest archievements' >> README.md
readarray -t my_array < <(echo "$ra_latestArchievementsResponse" | jq --compact-output '.[]')

echo '| Icon | Description | Date | Game |' >> README.md
echo '| - | - | - | - |' >> README.md
for item in "${my_array[@]}"; do
  ra_BadgeURL=$(jq --raw-output '.BadgeURL' <<< "$item")
  ra_Title=$(jq --raw-output '.Title' <<< "$item")
  ra_Description=$(jq --raw-output '.Description' <<< "$item")
  ra_Date=$(jq --raw-output '.Date' <<< "$item")
  ra_GameTitle=$(jq --raw-output '.GameTitle' <<< "$item")
  ra_GameIcon=$(jq --raw-output '.GameIcon' <<< "$item")
  # do your stuff

  echo "| <img src='https://retroachievements.org$ra_BadgeURL'> | **$ra_Title** <br> $ra_Description | $ra_Date | <p align='center'><img height='48px' src='https://retroachievements.org$ra_GameIcon'><br>$ra_GameTitle</p> |" >> README.md
done
