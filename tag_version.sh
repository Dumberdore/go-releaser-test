#!/bin/bash
set +x
tag_pattern="^v([0-9]+).([0-9]+).([0-9]+)$"

TAG_MAJOR=0
TAG_MINOR=0
TAG_PATCH=0
CURRENT_LATEST=$(git tag --sort=committerdate | tail -1)

if [ -z "$CURRENT_LATEST" ]; then
  CURRENT_LATEST="v0.0.0"
fi

echo "Latest repo version tag is $CURRENT_LATEST"

if [[ $CURRENT_LATEST =~ $tag_pattern ]]; then
  TAG_MAJOR="${BASH_REMATCH[1]}"
  TAG_MINOR="${BASH_REMATCH[2]}"
  TAG_PATCH="${BASH_REMATCH[3]}"
fi

NEW_VERSION=$(cat semver.txt)
new_pattern="^v([0-9]+).([0-9]+)$"

if [[ $NEW_VERSION =~ $new_pattern ]]; then
  FILE_MAJOR="${BASH_REMATCH[1]}"
  FILE_MINOR="${BASH_REMATCH[2]}"
else
  echo "Current version in semver.txt ${NEW_VERSION} does not appear to be in semver format"
fi

echo "Latest version in semver.txt is $NEW_VERSION"

TAG_PATCH=$((TAG_PATCH + 1))
# Reset patch if minor or major is set
if [ ! $FILE_MAJOR -eq $TAG_MAJOR ] || [ ! $FILE_MINOR -eq $TAG_MINOR ]; then
  TAG_PATCH=0
fi

NEW_TAG="v$FILE_MAJOR.$FILE_MINOR.$TAG_PATCH"
echo "New tag is $NEW_TAG. Pushing to repo."

git tag "$NEW_TAG" && git push origin --tags
