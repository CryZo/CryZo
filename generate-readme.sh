#!/bin/sh

echo '<picture>' > README.md
echo '  <source media="(prefers-color-scheme: dark)" srcset="dist/github-snake-dark.svg" />' >> README.md
echo '  <source media="(prefers-color-scheme: light)" srcset="dist/github-snake.svg" />' >> README.md
echo '  <img alt="github-snake" src="dist/github-snake.svg" />' >> README.md
echo '</picture>' >> README.md
