# Lands of Intrigue - Tethyr
is a NWN persistent world.

Join us at our forums https://landsofintrigue.guildtag.com/forums/ or Discord https://discord.gg/3saQtCZYwV

# Requirements

* docker
* python3
* pip install pyyaml

# How to add my module changes to the repository

Bug fixes are very welcome! But please do not submit unsolicited features for review. Contact us on discord or the forums first please.

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
git push --set-upstream origin myname_somethingDescriptive
```

Then, use the github website to find your branch and make a pull request against main. Ideally, there should be no conflicts. If there are, you will resolve them. With areas, this may be difficult to do through text, so you may want to get in contact with the person who made the change that conflicts with yours to get an idea of how to best fix it. You may find it easiest to undo your change, perform this process, then redo your change after.

Check your pull request to make sure that it only contains your changes.

> All pull requests by contributors are expected to be tested beforehand in a locally run server (see docker-compose.yaml) with a comprehensive description.

# Baked in dependencies

The data/ folder is from the nwserver 8193.35.40

The lib/ tools are from 
* https://github.com/nwneetools/nwnsc
* https://github.com/niv/neverwinter.nim

