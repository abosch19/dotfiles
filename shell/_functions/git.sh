push() {
	git push origin $(git rev-parse --abbrev-ref HEAD)
}

pull() {
	git pull origin $(git rev-parse --abbrev-ref HEAD)
}
