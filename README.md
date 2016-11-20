drone-git-sparseCheckout
========================

![license](https://img.shields.io/badge/license-GPLv3.0-brightgreen.svg?style=flat)

A [Drone](https://drone.io) CI v0.5 plugin to give the ability to use [git](https://en.wikipedia.org/wiki/Git)'s [sparseCheckout](https://git-scm.com/docs/git-read-tree#_sparse_checkout) feature.

## How to

Use docker image [peterdavehello/drone-git-sparse-checkout](https://hub.docker.com/r/peterdavehello/drone-git-sparse-checkout/) for clone process, set the **sparseCheckout** value to the file contains the sparseCheckout file list, additionally, give the clone depth you want, that's all.

Reference:
http://readme.drone.io/0.5/usage/customize-clone/

## Example

```yaml
clone:
  image: peterdavehello/drone-git-sparse-checkout
    depth: 5
    sparseCheckout: sparseCheckout-list.txt
```

## Note

To leverage the benifit of sparseCheckout - do not checkout all the files to filesystem, actually the real process here is to *init* an *empty* git repository, setup remote and sparseCheckout, and then *pull* from remote, would be a little bit different then the origin git clone.

In short, the `git clone` here is actually `git pull` with pre-set repository and configs.

## License

GPL-3.0
