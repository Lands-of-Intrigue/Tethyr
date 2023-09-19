# Lands of Intrigue Tethyr
is a NWN persistent world

Join us at our forums https://landsofintrigue.guildtag.com/forums/ or Discord https://discord.gg/3saQtCZYwV

# Requirements (WIP)

docker
python3
pip install pyyaml

# How to add my module changes to the repository


```
git checkout main
git pull
```

Update packer_settings.xml so that the 'from' field is pointing to your module

Now, you need to set a detached head in git to the point in time that you pulled your module from on main.
You can find the commit hash ids from inspecting the history of the main branch.

For example:
```
git checkout 5a6c69b8e1a268c3266929a06f30ab0b8191e215
git branch myname_somethingDescriptive
git checkout myname_somethingDescriptive
python module_packer.py unpack
git add src
git commit
git pull origin main
git commit
git push --set-upstream origin myname_somethingDescriptive
```

Then, use the github website to find your branch and make a pull request against main.

Check your pull request to make sure that it only contains your changes.

All pull requests by contributors are expected to be tested beforehand in a locally run server (see docker-compose.yaml) with a comprehensive description.

Bug fixes are very welcome! Please do not submit unsolicited features for review. Contact us on discord or the forums first please.

# Baked in dependencies

data folder is from the nwserver 8193.35.40

lib is from 
* https://github.com/nwneetools/nwnsc
* https://github.com/niv/neverwinter.nim

