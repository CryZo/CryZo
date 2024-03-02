#!/bin/sh

echo '<picture>' > README.md
echo '  <source media="(prefers-color-scheme: dark)" srcset="github-snake-dark.svg" />' >> README.md
echo '  <source media="(prefers-color-scheme: light)" srcset="github-snake.svg" />' >> README.md
echo '  <img alt="github-snake" src="github-snake.svg" />' >> README.md
echo '</picture>' >> README.md
