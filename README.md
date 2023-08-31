# Lands of Intrigue Tethyr
is a NWN persistent world

Join us at our forums https://landsofintrigue.guildtag.com/forums/ or Discord https://discord.gg/3saQtCZYwV

# Requirements (WIP)

docker
python3
pip install pyyaml

# How to add my module changes to the repository


```
git pull
git checkout main
```

Update packer_settings.xml so that the 'from' field is pointing to your module

```
git branch myname_somethingDescriptive
git checkout 
python module_packer.py unpack
git pull origin main
git commit
git push –-set-upstream origin myname_somethingDescriptive
```

Then, use the github website to find your branch and make a pull request against main

# Baked in dependencies

data folder is from the nwserver 8193.35.40

lib is from 
* https://github.com/nwneetools/nwnsc
* https://github.com/niv/neverwinter.nim

