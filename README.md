# Lands of Intrigue - Tethyr
is a NWN persistent world.

Join us at our forums https://landsofintrigue.guildtag.com/forums/ or Discord https://discord.gg/3saQtCZYwV

# Requirements

* docker
* python3
    * pip install pyyaml
* Neverwinter Nights Aurora Toolset

# Contributions

Bug fixes are very welcome! But please do not submit unsolicited features for review. Contact us on discord or the forums first please.

The workflow cycle is to fork or branch from the most recent commit in the 'main' branch. Make sure to keep track of the commit id if you aren't confident in your git ability to retrace your steps to find it again.

## General Workflow

Create a fork or a branch of off main in this repository. Google can help if you are unfamiliar with the basics of git.

Within your Tethyr directory, you now have all of the scripts and gff data required to build a the .mod file. Check your packer_settings.yml for the 'to' destination and ensure that is where you want your .mod file to build out to.

```
python module_packer.py pack
```

This will compile the scripts and convert the json resources into nwn gff format files. Make sure _not_ to make any further changes to the files under /src while this is in progress. It should take about 4-5 minutes on a modern computer.

Now, you have a .mod file! Copy paste it to your Neverwinter Nights/modules so that you can open it in a toolset. Make your changes as needed, then save and exit the toolset. This is very important.

Then, you will need to extract your changes to the Tethyr/src local repo. Do this by configuring the packer_settings.yml for the 'from' destination to match the .mod file you just saved. Then, run the following from Tethyr/

```
python module_packey.py unpack
```

Let this run to completion! It should be a couple minutes faster than the pack since it doesn't need to compile. From here, you can see your changes by the following:

```
git add src
git status
```

Commit and push your round of changes to your personal branch or fork, then repeat until you are ready for a pull request!


## When main has progressed between work cycles

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

