//:://////////////////////////////////////////////
//:: Name:     Bedlamson's Dynamic Merchant System
//:: FileName: bdm__readme
//:: Copyright (c) 2003 Stephen Spann.
//:://////////////////////////////////////////////
//:: Created By: Bedlamson
//:: Created On: 1/23/2003
//:://////////////////////////////////////////////
/*

NOTE: This isn't a functioning script, so if you
      have the instructions and parameters
      elsewhere, or you already know what you are
      doing, you can delete this script from your
      module with no problem.

INSTALLATION:

(1). Import the bdm_scripts.erf with the scripts
     and the 'stealstore' merchant, and the
     template merchant conversation. Optionally,
     you may import the bdm_samples.erf for some
     sample merchant objects using this system.

(2). Set up the module, your NPC merchant, your
     merchant object, and your NPC merchant's
     conversation to have the scripts as detailed
     in the chart below.

     If your NPC already has a custom script in the
     OnSpawn event, or your module already has a
     custom script in the OnItemAcquired or
     OnItemUnAquire event, just cut and paste the
     code in the 'bdm_' files and add them to your
     custom scripts. You will also need to add a
     line to include 'bdm_include' at the top.

(3). Make sure that your primary merchant object is
     closest to where the NPC spawns in, and that the
     cache merchant objects are closer than any other
     caches for other merchants. If using a waypoint
     for parameters, make sure it is the closest
     waypoint beginning with 'M_' to the NPC as well.

(3). Set the parameters you wish to use in the tag of
     your primary merchant object, and any cache
     merchant objects you are using for a dynamic
     inventory as detailed in the parameters section.
     The tag of the primary merchant object must begin
     with 'M_' and the tags for the caches must begin
     with 'C_'.

    NOTE: The Tag can only be 32 characters, which
          limits the amount of parameters you can set.
          To work around this, use a waypoint nearby
          the NPC instead, setting the Name of the
          waypoint to have the parameters. The reason
          the name of the merchant object isn't used
          is because it returns an invalid string with
          GetName(). If you are using a waypoint
          instead, be sure that the primary merchant
          object doesn't begin with 'M_', and that the
          waypoint does.

These scripts have four different elements, all
or any of which may be implemented at once. The
elements, and the minimum setup they require, are
as follows:

-----------------------------------------------------------+
An 'x' indicates  | HAGGLING, FAVORITISM, AND PREJUDICE  / |
that a script or  +------------------------------------+   |
template is       | DYNAMIC INVENTORIES              / |   |
used by a         +--------------------------------+   |   |
particular        | STEALING FROM MERCHANTS      / |   |   |
element.          +----------------------------+   |   |   |
                  | STORE CLEAN UP           / |   |   |   |
===========================================+   |   |   |   |
 SCRIPT/TEMPLATE  | WHERE IT GOES          |   |   |   |   |
-------------------------------------------|   |   |   |   |
 WHAT IT DOES                              |   |   |   |   |
===========================================|===|===|===|===|
 bdm_cnv_opn_stor | Merchant Conversation  | C | S | D | H |
                  | Actions Taken          |   |   |   |   |
-------------------------------------------|   |   |   |   |
 Opens the store with price adjustments    |   |   |   |   |
 for haggling, prejudice and favoritism.   |   |   |   |   |
 Also tags the store with who last opened  |   |   |   |   |
 it, for use with other scripts.           |   |   | x | x |
===========================================|===|===|===|===|
 bdm_cnv_stl_test | Merchant Conversation  | C | S | D | H |
                  | Text Appears When...   |   |   |   |   |
-------------------------------------------|   |   |   |   |
 Checks if the PC is trained in the        |   |   |   |   |
 Pick Pocket skill and whether             |   |   |   |   |
 stealing is enabled for the merchant.     |   | x |   |   |
===========================================|===|===|===|===|
 bdm_cnv_steal    | Merchant Conversation  | C | S | D | H |
                  | Actions Taken          |   |   |   |   |
-------------------------------------------|   |   |   |   |
 Makes a check with the PCs Pick Pocket    |   |   |   |   |
 skill opposed to the Merchant's Spot      |   |   |   |   |
 skill. Opens the 'stealstore' if the PC   |   |   |   |   |
 was not spotted.                          |   | x |   |   |
===========================================|===|===|===|===|
 bdm_merch_spawn  | NPC Merchant           | C | S | D | H |
                  | OnSpawn Event          |   |   |   |   |
-------------------------------------------|   |   |   |   |
 Sets up the store, caches, and parameters |   |   |   |   |
 for the merchant.                         | x | x | x | x |
===========================================|===|===|===|===|
 bdm_mod_acquire  | Module                 | C | S | D | H |
                  | OnAcquireItem Event    |   |   |   |   |
-------------------------------------------|   |   |   |   |
 Destroys the temporary store created for  |   |   |   |   |
 a PC to steal from, restricting them to   |   |   |   |   |
 stealing only one item at a time.         |   | x |   |   |
===========================================|===|===|===|===|
 bdm_mod_unacquir | Module                 | C | S | D | H |
                  | OnUnAcquireItem Event  |   |   |   |   |
-------------------------------------------|   |   |   |   |
 Used for untagging items as dynamic so    |   |   |   |   |
 that they don't interfere with a store's  |   |   |   |   |
 dynamic behavior, and records the time    |   |   |   |   |
 the item was sold for clean up purposes.  | x |   | x |   |
===========================================|===|===|===|===|
 bdm_store_open   | Main Merchant Object   | C | S | D | H |
                  | OnOpenStore Event      |   |   |   |   |
-------------------------------------------|   |   |   |   |
 Changes the inventory of a store every    |   |   |   |   |
 time it is opened, depending on the       |   |   |   |   |
 parameters set.  This includes dynamic    |   |   |   |   |
 items from cache merchant objects, as     |   |   |   |   |
 as destroying objects that were sold to   |   |   |   |   |
 the merchant by PCs after the set time.   | x |   | x |   |
===========================================|===|===|===|===|
 stealstore       | Merchant Palette       | C | S | D | H |
-------------------------------------------|   |   |   |   |
 This an empty store, with buy and sell    |   |   |   |   |
 mark ups and downs set to '1'. It is      |   |   |   |   |
 created when a PC successfully steals     |   |   |   |   |
 from a store, and is filled with the      |   |   |   |   |
 store's inventory.                        |   | x |   |   |
===========================================|===|===|===|===|
 bdm_merch_conv   | Conversations          | C | S | D | H |
-------------------------------------------|   |   |   |   |
 This a template for conversations using   |   |   |   |   |
 the dynamic merchant system. The scripts  |   |   |   |   |
 are in the correct places for all of the  |   |   |   |   |
 features.                                 |   |   |   |   |
===========================================|===|===|===|===|



===================================================
||      PARAMETERS - MAIN INVENTORY              ||
===================================================

The following parameters can be set on the tags of
the merchant object with the main inventory.
Parameters on the cache merchants are given later.

To set up the parameters for the main merchant
object, the tag must begin with 'MERCH_' and follow
with your parameters.

Example:  M_CL_HD_DC10

    This tag would make the merchant clean his
    inventory of items sold to him by PCs every
    time the store was opened, and allow PCs to
    haggle down the prices with a difficulty
    of 10.

It doesn't matter what order the switches are in,
so long as the tag begins with 'M_' and there is
an '_' separating each parameter.

NOTE: The reason this script uses the Tag and not
      the Name is because GetName() returns an
      empty string when used on a merchant.
      Unfortunately, the maximum tag length of a Tag
      is 32 characters, which severely limits the
      amount of parameters you can use at one time.
      To get around this, set up a waypoint very close
      to the NPC merchant with a NAME following the
      same structure given here. This will allow for
      a lot more parameters to be used (Not sure if
      there is a limit or not). The Tag of the
      merchant object should be changed to anything
      that doesn't start with 'MERCH_', and the scripts
      will read the parameters from the waypoint
      instead of the merchant. If you're not using that
      many parameters, its just simpler to use the
      merchant object's Tag.

==================
GENERAL PARAMETERS
==================

_CL     CLEAN INVENTORY:
_CLxx   This sets whether the merchant cleans his inventory of
_CLxxM  items sold to him by PCs. If 'xx' is set to an integer
_CLxxH  (01 - 99), the merchant will keep items in his inventory
        for that long in seconds after they are sold to him.
        Use 'M' or 'H' to change the amount of time to
        minutes or hours.

_CLxxRxx    As above, but a random amount of time between
_CLxxRxxM   the first 'xx' and the second 'xx'
_CLxxRxxH

        NOTE: The random amount of time is determined when
              the store recieves the item, not every time
              the store is opened.

===================
HAGGLING PARAMETERS
===================

(1). Requires these parameters:

    _HPxx   HAGGLE PERCENT:
            The percent an item is marked up or down as a
            result of a Persuade skill check.
            (Persuade Rank + Charisma Modifier)
            The default is not cumulative for higher/lower
            successes.

            NOTE: This number is added to the numbers in the
                  merchant object's 'Advanced' tab (Mark Up
                  Percent and Mark Down Percent). This means that
                  it won't be exactly the percent you put in the
                  parameter. Be sure to playtest for the best
                  results.

    _DCxx   HAGGLE DIFFICULTY:
            The difficulty of the skill check mentioned above.

(2). Requires one of the following parameters:

    _HA     HAGGLE ALL:
            Enables all of the possibilities for haggling.

    _HD     HAGGLE DOWN: (Good for the PC)
            Allows PCs to haggle down prices sold by the store,
            and haggle for more gold on items sold.

    _HU     HAGGLE UP: (Bad for the PC)
            Allows for the merchant to haggle up prices sold by
            the store, and haggle down the amount of gold he
            gives for items sold to him.

    _HB     HAGGLE BUY:
            Allows for the PC and the merchant to haggle on
            items the PC is buying.

    _HS     HAGGLE SELL:
            Allows for the PC and the merchant to haggle on
            items the PC is selling.

    _HD_HB      Allows the PC to haggle down prices on items
                sold by the store.

    _HD_HS      Allows the PC to haggle up prices on items
                bought by the store.

    _HU_HB      Allows the Merchant to haggle up prices on
                items sold to the PC.

    _HU_HS      Allows the Merchant to haggle down prices on
                items sold by the PC.

    NOTE: 'Up' and 'Down' aren't necessarily what they seem when
          it comes to PCs selling items to the merchant.  'Down'
          is good for the PC in all cases, and 'Up' is bad for
          the PC in all cases.

(3). Options:

    _HC     HAGGLE CUMULATIVE:
            Makes the result of the Haggle skill check
            cumulative.  For example, if the store's haggle DC
            is 10, the haggle percent is 1%, and a PC has 10 ranks
            of persuade and a +2 charisma modifier, he/she is
            successful. Normally, prices would only be changed by
            1%, but if the cumulative option is set, it would be
            changed by 2%. That's 1% for each point above the DC.

    _HMxx   HAGGLE MODIFIER:
            This parameter increases the score needed to both
            pass and fail the haggle check. For example, if the
            parameter '_HM01' is present in the tag and the
            difficulty is 4, a player will need a score of 6 to
            pass the check instead of just 5, and will need a
            score of 2 to fail the check instead of just 3.

            NOTE: If the haggle modifier is used with either the
                  fail or pass modifier below, the effects will
                  stack.

    _FMxx   FAILURE MODIFIER:
            This parameter increases the score needed to fail
            the haggle check. For example, if the parameter
            '_FM02' is present in the tag and the difficulty is
            10, a player will need a score of 7 to fail the check,
            instead of just 9.

    _PMxx   PASS MODIFIER:
            This parameter increases the score needed to pass
            the haggle check. For example, if the parameter
            '_PM03' is present in the tag and the difficulty is
            8, a player will need a score of 12 to pass the check,
            instead of just 9.

Examples:

MERCH_HD_HB_DC12_HP02 - Only allows the PC to haggle prices in his
                        favor on items sold to him, but with a DC
                        of 12. The prices can only be changed by
                        2%, no matter how successful the PC is.

MERCH_HA_DC05_HP01_HC - Allows both the merchant and the PC to haggle
                        prices on items bought and sold, with a DC of
                        5% The price change depends on how successful
                        or unsuccessful the PC is.

    NOTE: Configurations like the second example above can have
          strange results, like the PCs being able to sell things
          for more than they bought them for, especially in combination
          with favoritism. Be careful, and be sure to incorporate
          merchants into your playtesting.

=====================
FAVORITISM PARAMETERS
=====================

(1). Requires this parameter:

    _FPxx   FAVORITISM PERCENT:
            This is the percent that prices are changed in the
            PC's favor as a result of the merchant's favoritism.
            It lowers the price of items sold to the PC and
            raises the amount gold they receive for selling items
            to the merchant.

            NOTE: This number is added to the numbers in the
                  merchant object's 'Advanced' tab (Mark Up
                  Percent and Mark Down Percent). This means that
                  it won't be exactly the percent you put in the
                  parameter. Be sure to playtest for the best
                  results.

(2). Requires at least one of the following parameters:

    _FAxx   FAVORS ALIGNMENT:
            The merchant favors a particular alignment.
            The values for 'xx' are as follows:

            Groups:                     Specific:
            01 - Chaotic                07 - Chaotic Evil
            02 - Evil                   08 - Chaotic Good
            03 - Good                   09 - Chaotic Neutral
            04 - Lawful                 10 - Lawful Evil
            05 - Neutral (Good/Evil)    11 - Lawful Good
            06 - Neutral (Law/Chaos)    12 - Lawful Neutral
                                        13 - Neutral Evil
                                        14 - Neutral Good
                                        15 - True Neutral

    _FAxxAxxAxx...  Allows the merchant to favor multiple alignments
                    or alignment groups.

            NOTE: PCs will only ever get the alignment bonus
                  once, even if their alignment matches with
                  more than one parameter given.

    _FCxx   FAVORS CLASS:
            The merchant favors a particular class.
            The values for 'xx' are as follows:

            01 - Barbarian      07 - Paladin
            02 - Bard           08 - Ranger
            03 - Cleric         09 - Rogue
            04 - Druid          10 - Sorcerer
            05 - Fighter        11 - Wizard
            06 - Monk

    _FCxxAxxAxx...  Allows the merchant to favor multiple classes.

    _FRxx   FAVORS RACE:
            The merchant favors a particular race.
            The values for 'xx' are as follows:

            Base Races:         Subraces:
            01 - Dwarf          05 - Halfling
            02 - Elf            06 - Half-orc
            03 - Gnome          07 - Human
            04 - Half-elf       08+  Subrace (non-ALFA method)

            NOTE: The non-ALFA subrace method does not require
                  any specific subrace system to be installed
                  in your module.  You do, however, need to
                  set up your module's subraces by editing the
                  'bdm_include' file under the CheckRace()
                  funtion. See the 'bdm_include' file for details.

            NOTE: Subrace bonuses using this method do not stack
                  with base racial bonuses.

    _FRxxAxxAxx...  Allows the merchant to favor multiple races.

    _FSxx   FAVORS SUBRACE: (ALFA method)
            The merchant favors a particular subrace.
            The values for 'xx' are as follows:

            02 - Gold Dwarf     11 - Rock Gnome
            03 - Gray Dwarf     12 - Half-elf
            04 - Shield Dwarf   13 - Half-orc
            05 - Dark Elf       14 - Ghostwise Halfling
            06 - Moon Elf       15 - Lightfoot Halfling
            07 - Sun Elf        16 - Strongheart Halfling
            08 - Wild Elf       17 - Human
            09 - Wood Elf       18 - Halfdrow
            10 - Deep Gnome     19+  CUSTOM

            NOTE: This function uses the ALFA subrace system. You
                  must first have it installed in your module,
                  and you must manually uncomment a function near
                  the top of the script 'bdm_include' for it to
                  work.

    _FSxxAxxAxx...  Allows the merchant to favor multiple subraces.

    _FGM    FAVORS GENDER:
    _FGF    The merchant favors a particular gender.
            Use '_FGM' for males, and '_FGF' for females.

(3). Options:

    _FL     FAVORITISM LINKED:
            This requires the PC to meet all of the favoritism
            requirements to be given the bonus. For example, a
            merchant with the tag of 'MERCH_FGM_FR07' favors
            all males and all humans, whereas a merchant with
            the tag of 'MERCH_FGM_FR07_FL' only favors human
            males.

    _FB     FAVORS FOR BUYING ONLY:
            The favoritism percent bonus is only applied when
            the merchant is buying an item from a PC.

    _FE     FAVORS FOR SELLING ONLY:
            The favoritism percent bonus is only applied when
            the merchant is selling an item to a PC.

    _FU     UNLIMITED FAVORTISM BONUSES:
            This makes it so that a character can get more than
            one bonus for their class, race, subrace, algnment,
            or gender. If this is not selected, a PC can only
            ever receive the favoritism percent bonus once.

Examples:

MERCH_FA07A11_FR01A03A05_FP02 - This merchant favors chaotic evil
                                characters, lawful good characters,
                                dwarves, gnomes, and halflings. Their
                                prices are adjusted by 2%.

MERCH_FC07A10_FA07A11_FP01_FL - This merchant favors lawful good
                                paladins, chaotic evil paladins,
                                lawful good sorcerers, and chaotic
                                evil sorcerers. Their prices are
                                adjusted by 1%.

    NOTE: It isn't possible to favor two specific different
          combinations of alignments/classes/races when they are
          linked. In the second example above, the module designer
          may have intended for it to be just lawful good paladins
          and chaotic evil sorcerers. The other two possibilities
          are present, however, even though chaotic evil paladins
          don't really exist.

====================
PREJUDICE PARAMETERS
====================

The parameters for prejudice are identical to the parameters for
favoritism as far as their functions. The only difference is that
if the PC meets the requirements, the prices are changed to the
PC's disadvantage.

See the previous section for details on their use.

(1). Requires this parameter:

    _PPxx

(2). Requires at least one of the following parameters:

    _PAxx
    _PAxxAxxAxx...
    _PCxx
    _PCxxAxxAxx...
    _PRxx
    _PRxxAxxAxx...
    _PSxx
    _PSxxAxxAxx...
    _PGM
    _PGF

(3). Options:

    _PL
    _PB
    _PE
    _PU

===================
STEALING PARAMETERS
===================

(1). Requires this parameter:

    _ST     ENABLE STEALING:
            Allows PCs with the 'Pick Pocket' skill to attempt
            to steal an item from this merchant. The PC will only
            be able to steal objects 'no larger than a hat or a
            loaf of bread' (PHB, p. 72). I interpreted this as
            any item no wider or longer than two inventory
            squares. This includes short swords, books, boots,
            helmets, belts, and the like. The PC must make an
            opposed skill check against the shopkeeper's Spot
            skill. The shopkeeper gets bonuses as detailed on
            page 74 of the PHB. The PC will only be able to steal
            one item per successful attempt.

(2). Options:

    _SA     STEAL ALL:
            Allows PCs to steal any item from the merchant, not
            just the ones 'no larger than a hat or a loaf of
            bread'.

    _SLxx   STEALING TIME LIMIT:
            This limits the PC to 'xx' seconds to make their
            selection before the temporary merchant is destroyed.

    _SLxxRxx    As above, except the number of seconds is a
                random value between the first 'xx' and the
                second 'xx'.

    _SCPx   STEALING CIRCUMSTANCE BONUS/PENALTY:
    _SCNx   This allows you to set a circumstance bonus or
            penalty for the PC. This has the same effect as
            raising or lowering the shopkeeper's Spot skill,
            except you can make it even easier for the PC to
            steal by giving a circumstance bonus, despite the
            shopkeeper's spot skill. Use 'SCPx' for bonuses,
            and 'SCNx' for penalties.

    _RH     REACTION HOSTILE:
            When a PC attemts to steal from a merchant and is
            spotted, this will make the PC's reputation -100 to
            the merchant's, faction, and the merchant will
            attack the PC. If all of your merchants are part of
            the 'Merchant' faction, or your server has the
            'One Party Only' option checked, this can cause
            major hostility and faction problems.

============================
DYNAMIC INVENTORY PARAMETERS
============================

(1). Requires these parameters:

    _NCxx   NUMBER OF CACHES:
            This is the number of extra merchant objects present
            that contain the dynamic items for the main inventory.

    _ITxx   MAXIMUM NUMBER OF DYNAMIC ITEMS:
            This is the maximum number of dynamic items from
            the caches that will be generated in the
            inventory of the main merchant object. If a number
            is not set, no dynamic items will be created. If
            the parameter '_PRxx' (percent chance) is set for
            any of the caches, the number of items created will
            usually be less than the value set here.

    _ITxxRxx    Same as above, only the maximum number of
                dynamic items created is a random number
                between the first 'xx' and the second 'xx'.

(2). Options:

    _UQ     ALL DYNAMIC ITEMS ARE UNIQUE:
            This will not allow two of the same dynamic item
            from each cache to be created. If an item exists
            in more than one cache, it will mess up this
            parameter. (As in there could potentially be two.)

    _TMxx   TIMER:
    _TMxxM  This is the amount of time that a merchant will wait
    _TMxxH  before changing a dynamic item. If 'xx' amount of
            time has passed since the store was last opened, one
            item will be destroyed, and one new one will
            (potentially) be created.  If 2x the amount of time
            has passed, then 2 dynamic items will be destroyed
            and (potentially) created ('potentially' depending
            on the '_PRxx' parameter of the caches). If this
            isn't set, or it is set to zero, all items will be
            replaced every time the store is opened.
            Use '_TMxx' for seconds, '_TMxxM' for minutes, and
            '_TMxxH' for hours.

    _TMxxRxx    The same as above, only the time is a random
    _TMxxRxxM   amount of time between the first 'xx' and the
    _TMxxRxxH   second 'xx'.

    _TL     TIMER LINKED FOR ALL ITEMS:
            This parameter works with the above parameter, and
            setting it will make all of the dynamic items
            regenerate after the amount of time specifiec in the
            '_TMxx' parameter.

    _IR     ITEMS REMAIN UNTIL SOLD:
            This will cause dynamic items to remain in the
            merchant's inventory until they are sold.
            (In effect, making '_TM' infinite).

    _RDxx   RANDOM DELETE:
            This will destroy 'xx' number of dynamic items
            every time the store is opened. They will either
            be replaced, or have a chance of being replaced.
            This occurs despite any other parameters, such
            as '_IR'.

===================================================
||            PARAMETERS - CACHES                ||
===================================================

All of these parameters are optional. A prefix of 'CACHE_'
before the parameters works great, but isn't required. Anything
that doesn't contain the two letters of a parameter next
to eachother will work.

    _PRxx   PERCENT CHANCE FOR EACH CACHE ITEM:
            This parameter represents the percent chance for
            every item in the cache to be added to the total
            item list each time an item is generated. It is not
            the percent chance of their being an item from the
            cache. For example: a merchant object with the Tag
            'C_PR01' and containing 10 items in it, will have
            a 1% chance of each item being added to the list, or
            a 10% chance of any of the items being added to the
            list. If you want a merchant to have a particular
            item very rarely, put it in its own cache with the
            tag 'C_PR01'. This will make it appear in the
            merchant's inventory 1/100 times the store is
            opened.

            NOTE: The items will have a chance of being
                  generated every time the store is opened,
                  so use the '_TMxx' parameter to set how
                  long inbetween regenerations you want.

    _UQ     ITEMS FROM CACHE ARE UNIQUE:
            This allows for other caches for the same merchant
            to not be unique, and keep items in this cache unique.
            if the '_UQ' parameter is set in the primary merchant,
            this parameter isn't necessary.

NOTE: The 'xx' values for the limits are the
      same as the values for the favoritism
      and prejudice values. See those sections
      for the lists.

NOTE: Putting a limit on a cache doesn't work exactly like it
      should, due to a lack of a way to trigger something when
      a PC closes a store, and a loack of a way to get what
      PCs have a store's inventory open. As a result, if a
      player who meets the limits has the store open, and the
      limited items are displayed, if a player who doesn't
      meet the limit requirements open the store as well, the
      limited items will vanish. This works the opposite way
      as well, with limited items appearing to a PC that
      doesn't meet the requirements who already had the store
      opened when a PC who meets the requirements opens the
      store. These issues could be solved if Bioware added a
      'OnCloseStore' event to merchant objects, and a
      scripting function like GetFirstPCAtMechant() and
      GetNextPCAtMerchant() or something similar. In reality,
      its probably better to just to set up a conversation
      with a node that tests for whatever limit you want, and
      open up a separate store entirely.

    _LAxx   LIMIT CACHE TO ALIGNMENT:
            The inventory of the cache only appears to
            characters of the selected alignment.

    _LAxxAxxAxx...

    _LCxx   LIMIT CACHE TO CLASS:
            The inventory of the cache only appears to
            characters of the selected class.

    _LCxxAxxAxx...

    _LRxx   LIMIT CACHE TO RACE:
            The inventory of the cache only appears to
            characters of the selected race.

    _LRxxAxxAxx...

    _LSxx   LIMIT CACHE TO SUBRACE:
            The inventory of the cache only appears to
            characters of the selected subrace.

    _LSxxAxxAxx...

    _LGM    LIMIT CACHE TO GENDER:
    _LGF    The inventory of the cache only appears to
            characters of the selected gender.

    _LL     CACHE LIMITS LINKED:
            The limits of the above parameters are linked,
            and the PC must meet a requirement from each
            limit selected.
