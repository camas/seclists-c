# seclists-c

This fork of [SecLists](https://github.com/danielmiessler/SecLists/) adds a few extra things. Mainly scripts to combine common lists, sort them and then remove any duplicates.

Updates from upstream are pulled when I feel like it.

## Changes

- Added list `Discovery/DNS/bitquark-subdomains-top1000000.txt`
- Added script `c-extensions/check_blank_ends.sh` which checks every `.txt` file for a trailing `\n`
- Added script `c-extensions/combine.sh` which creates sorted, unique combinations of related files
- Removed leading `/` from URLs in `Discovery/Web-Content`

## Upstream readme

The upstream readme is left as-is below.

---

![seclists.png](https://danielmiessler.com/images/seclists-long.png "seclists.png")

## About SecLists

SecLists is the security tester's companion. It's a collection of multiple types of lists used during security assessments, collected in one place. List types include usernames, passwords, URLs, sensitive data patterns, fuzzing payloads, web shells, and many more. The goal is to enable a security tester to pull this repository onto a new testing box and have access to every type of list that may be needed.

This project is maintained by [Daniel Miessler](https://danielmiessler.com/), [Jason Haddix](http://www.securityaegis.com), and [g0tmi1k](https://twitter.com/g0tmi1k).

---

## Install

### Zip

```console
wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip \
  && unzip SecList.zip \
  && rm -f SecList.zip
```

### Git (Small)

```console
git clone --depth 1 https://github.com/danielmiessler/SecLists.git
```

### Git (Complete)

```console
git clone https://github.com/danielmiessler/SecLists.git
```

### Kali Linux ([Tool Page](https://tools.kali.org/password-attacks/seclists))

```console
apt -y install seclists
```

---

## Attribution

See [CONTRIBUTORS.md](CONTRIBUTORS.md)

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

---

## Similar Projects

- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)
- [FuzzDB](https://github.com/fuzzdb-project/fuzzdb)

---

## Licensing

This project is licensed under the [MIT license](LICENSE).

![MIT License](https://danielmiessler.com/images/mitlicense.png)

---

<sup>NOTE: Downloading this repository is likely to cause a false-positive alarm by your anti-virus or anti-malware software, the filepath should be whitelisted. There is nothing in SecLists that can harm your computer as-is, however it's not recommended to store these files on a server or other important system due to the risk of local file include attacks.</sup>
