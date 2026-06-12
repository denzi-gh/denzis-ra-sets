// American Dragon: Jake Long - Rise of the Huntsclan
// #ID = 9405

// Memory accessors
function ScreenId() => byte(0x0019D0)
function ScreenMirror() => byte(0x00373C)
function PlayerForm() => byte(0x006CF0)
function isOnSkateboard() => byte(0x007014)
function HudVisible() => byte(0x006B50)
function PauseState() => byte(0x006B80)
function VictoryPose() => byte(0x007674)
function CameraLock() => byte(0x0074F0)
function StageTimerLow() => word(0x0062B4)
function StageTimerHigh() => word(0x0062B6)

// Screen IDs
SCREEN_BOOT = 0xC8
SCREEN_NON_STAGE = 0xC9
SCREEN_DEBUG = 0xC0
SCREEN_TUTORIAL = 0x3A
SCREEN_JUMP_IN_CUTSCENE = 0xCA
SCREEN_JUMP_IN_RETURN = 0xCB

// Regular stage IDs
STAGE_1_1 = 0x0B
STAGE_1_2 = 0x0E
STAGE_1_3 = 0x0F
STAGE_2_1 = 0x12
STAGE_2_2 = 0x14
STAGE_2_3 = 0x17
STAGE_3_1 = 0x19
STAGE_3_2 = 0x1C
STAGE_3_3 = 0x1E
STAGE_4_1 = 0x23
STAGE_4_2 = 0x25
STAGE_4_3 = 0x20
STAGE_5_1 = 0x27
STAGE_5_2 = 0x2A
STAGE_5_3 = 0x2C

// Boss stage IDs
BOSS_HUNTSGIRL = 0x37
BOSS_GIANT_SPIDER = 0x36
BOSS_CYCLOPS = 0x30
BOSS_MEDUSA = 0x35
BOSS_HUNTSGIRL_REMATCH = 0x38
BOSS_HUNTSCLAN_CLONES = 0x2E
BOSS_HUNTSMAN = 0x32

// Jake Positions
FORM_JAKE = 0
FORM_DRAGON = 1
VICTORY_POSE_ACTIVE = 2
ON_SKATEBOARD = 2
ON_SKATEBOARD_AIRBORNE = 3
PAUSE_STATE_UNPAUSED = 0x00
PAUSE_STATE_PAUSED = 0x01

RegularStageIds = [
    STAGE_1_1, STAGE_1_2, STAGE_1_3,
    STAGE_2_1, STAGE_2_2, STAGE_2_3,
    STAGE_3_1, STAGE_3_2, STAGE_3_3,
    STAGE_4_1, STAGE_4_2, STAGE_4_3,
    STAGE_5_1, STAGE_5_2, STAGE_5_3
]

BossStageIds = [
    BOSS_HUNTSGIRL,
    BOSS_GIANT_SPIDER,
    BOSS_CYCLOPS,
    BOSS_MEDUSA,
    BOSS_HUNTSGIRL_REMATCH,
    BOSS_HUNTSCLAN_CLONES,
    BOSS_HUNTSMAN
]

PlayableScreenIds = [
    STAGE_1_1, STAGE_1_2, STAGE_1_3,
    STAGE_2_1, STAGE_2_2, STAGE_2_3,
    STAGE_3_1, STAGE_3_2, STAGE_3_3,
    STAGE_4_1, STAGE_4_2, STAGE_4_3,
    STAGE_5_1, STAGE_5_2, STAGE_5_3,
    BOSS_HUNTSGIRL,
    BOSS_GIANT_SPIDER,
    BOSS_CYCLOPS,
    BOSS_MEDUSA,
    BOSS_HUNTSGIRL_REMATCH,
    BOSS_HUNTSCLAN_CLONES,
    BOSS_HUNTSMAN
]

// SCREEN HELPER
function IsScreen(screen) => ScreenId() == screen
function WasScreen(screen) => prev(ScreenId()) == screen

// Checks if the Player has entered a Jump In Cutscene
function IsJumpInScreen() => IsScreen(SCREEN_JUMP_IN_CUTSCENE) || IsScreen(SCREEN_JUMP_IN_RETURN)

// PLAYER FORM HELPER
function IsJakeForm() => PlayerForm() == FORM_JAKE
function IsDragonForm() => PlayerForm() == FORM_DRAGON
function IsVictoryPoseActive() => VictoryPose() == VICTORY_POSE_ACTIVE
function WasVictoryPoseActive() => prev(VictoryPose()) == VICTORY_POSE_ACTIVE
function IsInStage(stage) => IsScreen(stage)
function LeftStage(stage) => WasScreen(stage) && ScreenId() != stage
function JakeIsFullHealth() => byte(0x007026) == 74

function TookDamage() => JakeHealth() < 74
function IsSkateboarding() => isOnSkateboard() == ON_SKATEBOARD || isOnSkateboard() == ON_SKATEBOARD_AIRBORNE
function IsPaused() => PauseState() == PAUSE_STATE_PAUSED
function IsUnpaused() => PauseState() == PAUSE_STATE_UNPAUSED

//HUNTSGIRL BOSS FIGHT HELPER
function HuntsgirlFullHP() => byte(0x041802) == 20
function HuntsgirlRematchFullHP() => byte(0x041802) == 30
function HuntsgirlDefeated() => byte(0x041802) == 0
function JakeHealth() => byte(0x007026)
function HuntsgirlHp() => byte(0x041802)
function HuntsgirlDefeatedDelta() => HuntsgirlHp() == 0 && prev(HuntsgirlHp()) > 0

//GIANT SPIDER BOSS FIGHT HELPER
function GiantSpiderFullHP() => byte(0x041b0e) == 80
function GiantSpiderDefeated() => byte(0x041b0e) == 0
function JakeHealth() => byte(0x007026)
function GiantSpiderHp() => byte(0x041b0e)
function GiantSpiderDefeatedDelta() => GiantSpiderDefeated() && prev(GiantSpiderHp()) > 0 && prev(GiantSpiderHp()) <= 80

//CYCLOPS BOSS FIGHT HELPER
function CyclopsFullHP() => byte(0x041b0a) == 22
function CyclopsDefeated() => byte(0x041b0a) == 0xFF
function JakeHealth() => byte(0x007026)
function CyclopsHp() => byte(0x041b0a)
function CyclopsDefeatedDelta() => CyclopsDefeated() && prev(CyclopsHp()) > 0 && prev(CyclopsHp()) <= 22
function CyclopsTimerRunning() => IsScreen(BOSS_CYCLOPS) && IsUnpaused()

//GIANT MEDUSA BOSS FIGHT HELPER
function GiantMedusaFullHP() => byte(0x041dca) == 12
function GiantMedusaDefeated() => byte(0x041dca) == 0
function JakeHealth() => byte(0x007026)
function GiantMedusaHp() => byte(0x041dca)
function GiantMedusaDefeatedDelta() => GiantMedusaHp() == 0 && prev(GiantMedusaHp()) > 0


// Checks if the player has left a Stage and the Victory Pose is active during it
function StageClearCandidate(stage) => LeftStage(stage) && IsVictoryPoseActive()
function LeftJumpInReturn() => WasScreen(SCREEN_JUMP_IN_RETURN) && ScreenId() != SCREEN_JUMP_IN_RETURN
function BossStageClearCandidate(stage) => once(IsScreen(stage)) &&
                                           (LeftStage(stage) || LeftJumpInReturn()) &&
                                           (IsVictoryPoseActive() || WasVictoryPoseActive())

// TIMER HELPER
function StageTimer() => StageTimerHigh() * 65536 + StageTimerLow()

//HUNTSCLAN CLONES BOSS FIGHT HELPER
CLONE_TANK_HP_ADDRESSES = [
    //Adresses are always +0x2E0
    0x0420A6,
    0x042386,
    0x042666,
    0x042946,
    0x042C26,
    0x042F06,
    0x0431E6
]
CLONE_TANK_EMPTY_HP = 0x00
CLONE_TANK_DEFEATED = 0xFF

function CloneTankHp(address) => byte(address)
function CloneTankDefeatedDelta() => any_of(CLONE_TANK_HP_ADDRESSES, address => IsScreen(BOSS_HUNTSCLAN_CLONES) && CloneTankHp(address) == CLONE_TANK_DEFEATED && prev(CloneTankHp(address)) == CLONE_TANK_EMPTY_HP)
function HuntsclanClonesTimerRunning() => IsScreen(BOSS_HUNTSCLAN_CLONES) && IsUnpaused()
function LeftHuntsclanClonesAttempt() => WasScreen(BOSS_HUNTSCLAN_CLONES) && ScreenId() != BOSS_HUNTSCLAN_CLONES && ScreenId() != SCREEN_JUMP_IN_CUTSCENE && ScreenId() != SCREEN_JUMP_IN_RETURN

//HUNTSMAN Helper
HUNTSMAN_HP_ADDRESSES = [
    0x0423DC,
    0x041B3C
]

HUNTSMAN_FINAL_PHASE_HP = 0x08
HUNTSMAN_LAST_HP = 0x01
HUNTSMAN_DEFEATED_HP = 0x00

function HuntsmanHp(address) => byte(address)
//Huntsman has four Phases and regenerates Health in that Order: 3, 3, 6, 8 - HP must be 0x08 once (that detects if the Final Phase is reached)
function HuntsmanFinalPhaseDefeatedDelta() => any_of(HUNTSMAN_HP_ADDRESSES, address => once(HuntsmanHp(address) == HUNTSMAN_FINAL_PHASE_HP) && HuntsmanHp(address) == HUNTSMAN_DEFEATED_HP && prev(HuntsmanHp(address)) == HUNTSMAN_LAST_HP)




//WORLD 1 ACHIEVEMENTS

achievement(
    title = "Skate Through the Streets",
    description = "Clear Stage 1-1 through the streets of New York City",
    points = 5,
    trigger = StageClearCandidate(STAGE_1_1)
)

achievement(
    title = "Fire Escape Chase",
    description = "Clear Stage 1-2 and take the fight up the fire escapes",
    points = 5,
    trigger = StageClearCandidate(STAGE_1_2)
)

achievement(
    title = "Rooftop Pursuit",
    description = "Clear Stage 1-3 across the rooftops",
    points = 5,
    trigger = StageClearCandidate(STAGE_1_3)
)

achievement(
    title = "Rooftop Date",
    description = "Defeat the Huntsgirl and complete World 1",
    points = 10,
    type = "progression",
    trigger = once(HuntsgirlDefeatedDelta()) &&
              BossStageClearCandidate(BOSS_HUNTSGIRL)
)


achievement(
    title = "Love at First Fight",
    description = "Defeat the Huntsgirl without Jump Ins and without taking damage",
    points = 25,
    type = "missable",
    trigger = once(IsScreen(BOSS_HUNTSGIRL)) &&
              once(HuntsgirlFullHP()) &&
              never(TookDamage()) &&
              never(IsJumpInScreen()) &&
              trigger_when(HuntsgirlDefeatedDelta())
)


//WORLD 2 ACHIEVEMENTS

achievement(
    title = "Into the Sewers",
    description = "Clear Stage 2-1 and descend into the sewers",
    points = 5,
    trigger = StageClearCandidate(STAGE_2_1)
)

achievement(
    title = "Down, Down, Down",
    description = "Clear Stage 2-2 deeper underground",
    points = 5,
    trigger = StageClearCandidate(STAGE_2_2)
)

achievement(
    title = "Elevator Shaft Scramble",
    description = "Clear Stage 2-3 through the sewer elevator shafts",
    points = 5,
    trigger = StageClearCandidate(STAGE_2_3)
)

achievement(
    title = "Web of Trouble",
    description = "Defeat the Giant Spider and complete World 2",
    points = 10,
    type = "progression",
    trigger = once(GiantSpiderDefeatedDelta()) &&
              BossStageClearCandidate(BOSS_GIANT_SPIDER)
)

achievement(
    title = "No Board, No Bites",
    description = "Defeat the Giant Spider without Jump Ins, without using the skateboard and without taking damage",
    points = 25,
    type = "missable",
    trigger = once(IsScreen(BOSS_GIANT_SPIDER)) &&
              once(GiantSpiderFullHP()) &&
              never(TookDamage()) &&
              never(IsSkateboarding()) &&
              never(IsJumpInScreen()) &&
              trigger_when(GiantSpiderDefeatedDelta())
)


//WORLD 3 ACHIEVEMENTS

achievement(
    title = "Bridge Out",
    description = "Clear Stage 3-1 and reach the New York bridge",
    points = 5,
    trigger = StageClearCandidate(STAGE_3_1)
)

achievement(
    title = "Rush-Hour Dragon",
    description = "Clear Stage 3-2 through the traffic",
    points = 5,
    trigger = StageClearCandidate(STAGE_3_2)
)

achievement(
    title = "Helicopter Hazard",
    description = "Clear Stage 3-3 past the helicopter pursuit",
    points = 5,
    trigger = StageClearCandidate(STAGE_3_3)
)

achievement(
    title = "Eye on the Bridge",
    description = "Defeat the Cyclops and complete World 3",
    points = 10,
    type = "progression",
    trigger = once(CyclopsDefeatedDelta()) &&
              BossStageClearCandidate(BOSS_CYCLOPS)
)

CYCLOPS_TIME_LIMIT = 2 * 60 * 60 //(2 minutes in frames)

achievement(
    title = "MY EYE!!!",
    description = "Defeat the Cyclops in under 2 Minutes, without using Jump Ins and without taking damage",
    points = 25,
    type = "missable",
    trigger = once(IsScreen(BOSS_CYCLOPS)) &&
              never(TookDamage()) &&
              never(IsJumpInScreen()) &&
              disable_when(repeated(CYCLOPS_TIME_LIMIT, CyclopsTimerRunning())) &&
              trigger_when(CyclopsDefeatedDelta())
)


//WORLD 4 ACHIEVEMENTS

achievement(
    title = "Down by the Docks",
    description = "Clear Stage 4-1 at the docks",
    points = 5,
    trigger = StageClearCandidate(STAGE_4_1)
)

achievement(
    title = "Across the Water",
    description = "Clear Stage 4-2 on the way to the island lair",
    points = 5,
    trigger = StageClearCandidate(STAGE_4_2)
)

achievement(
    title = "Island of Snakes",
    description = "Clear Stage 4-3 and reach Medusa’s lair",
    points = 5,
    trigger = StageClearCandidate(STAGE_4_3)
)

achievement(
    title = "Hair-Raising Medusa",
    description = "Defeat Giant Medusa and complete World 4",
    points = 10,
    type = "progression",
    trigger = once(GiantMedusaDefeatedDelta()) &&
              BossStageClearCandidate(BOSS_MEDUSA)
)

achievement(
    title = "Slither Skater",
    description = "Defeat Giant Medusa without Jump Ins, without using the skateboard and without taking damage",
    points = 25,
    type = "missable",
    trigger = once(IsScreen(BOSS_MEDUSA)) &&
              once(GiantMedusaFullHP()) &&
              never(TookDamage()) &&
              never(IsJumpInScreen()) &&
              trigger_when(GiantMedusaDefeatedDelta())
)

//WORLD 5 ACHIEVEMENTS

achievement(
    title = "Temple Trouble",
    description = "Clear Stage 5-1 and enter the Huntsclan stronghold",
    points = 5,
    trigger = StageClearCandidate(STAGE_5_1)
)

achievement(
    title = "Dungeon Descent",
    description = "Clear Stage 5-2 through the dungeon",
    points = 5,
    trigger = StageClearCandidate(STAGE_5_2)
)

achievement(
    title = "Final Showdown Approach",
    description = "Clear Stage 5-3 and reach the final showdown",
    points = 5,
    trigger = StageClearCandidate(STAGE_5_3)
)

achievement(
    title = "Huntsgirl: The Return",
    description = "Defeat Huntsgirl again and complete World 5",
    points = 10,
    type = "progression",
    trigger = once(HuntsgirlDefeatedDelta()) &&
              BossStageClearCandidate(BOSS_HUNTSGIRL_REMATCH)
)

achievement(
    title = "Grounded Rematch",
    description = "Defeat the Huntsgirl rematch without Jump Ins, without using the skateboard and without taking damage",
    points = 25,
    type = "missable",
    trigger = once(IsScreen(BOSS_HUNTSGIRL_REMATCH)) &&
              once(HuntsgirlRematchFullHP()) &&
              never(TookDamage()) &&
              never(IsJumpInScreen()) &&
              never(IsSkateboarding()) &&
              trigger_when(HuntsgirlDefeatedDelta())
)

// Huntsman Clones Achievements

achievement(
    title = "Clone Pile-Up",
    description = "Defeat the Huntsclan Clones and complete the game",
    points = 50,
    type = "win_condition",
    trigger = BossStageClearCandidate(BOSS_HUNTSCLAN_CLONES)
)

HUNTSCLAN_CLONES_TIME_LIMIT = 5 * 60 * 60 //(5 minutes in frames)

achievement(
    title = "Young, Fast, and Cloning",
    description = "Defeat the Huntsclan Clones in under 5(WIP) minutes without using Jump-Ins",
    points = 25,
    type = "missable",
    trigger = once(IsScreen(BOSS_HUNTSCLAN_CLONES)) &&
              disable_when(IsJumpInScreen(), LeftHuntsclanClonesAttempt()) &&
              disable_when(repeated(HUNTSCLAN_CLONES_TIME_LIMIT, HuntsclanClonesTimerRunning()), LeftHuntsclanClonesAttempt()) &&
              trigger_when(CloneTankDefeatedDelta())
)

// HUNTSMAN FINAL BOSS ACHIEVEMENTS

achievement(
    title = "Take that, Huntsfool!",
    description = "Defeat the Huntsman",
    points = 25,
    trigger = BossStageClearCandidate(BOSS_HUNTSMAN)
)

achievement(
    title = "Huntsman, More Like HuntsCAN'T",
    description = "Defeat the Huntsman without using Jump-Ins and without taking damage",
    points = 50,
    type = "missable",
    trigger = once(IsScreen(BOSS_HUNTSMAN)) &&
              never(TookDamage()) &&
              never(IsJumpInScreen()) &&
              // Huntsman reaches 0 multiple times and regenerates due to Phases, helper checks if Health was 0x08 (Last Phase Health) once
              trigger_when(HuntsmanFinalPhaseDefeatedDelta())
)
//RICH PRESENCE//

StageNameLookup = {
    0xC0: "the Debug Menu",
    0x3A: "the Tutorial",
    0x0B: "Stage 1-1",
    0x0E: "Stage 1-2",
    0x0F: "Stage 1-3",
    0x37: "the Huntsgirl boss fight",
    0x12: "Stage 2-1",
    0x14: "Stage 2-2",
    0x17: "Stage 2-3",
    0x36: "the Giant Spider boss fight",
    0x19: "Stage 3-1",
    0x1C: "Stage 3-2",
    0x1E: "Stage 3-3",
    0x30: "the Cyclops boss fight",
    0x23: "Stage 4-1",
    0x25: "Stage 4-2",
    0x20: "Stage 4-3",
    0x35: "the Medusa boss fight",
    0x27: "Stage 5-1",
    0x2A: "Stage 5-2",
    0x2C: "Stage 5-3",
    0x38: "the Huntsgirl rematch",
    0x2E: "the Huntsclan Clones boss fight",
    0x32: "the Huntsman final boss fight",
}

StageAreaLookup = {
    0x0B: "Downtown",
    0x0E: "Downtown",
    0x0F: "Downtown",
    0x12: "Underground",
    0x14: "in the Old Sewer Tunnel",
    0x17: "in the Old Sewer Tunnel",
    0x19: "on the New York Bridge",
    0x1C: "on the New York Bridge",
    0x1E: "on the New York Bridge",
    0x23: "in the Docks",
    0x25: "in the Docks",
    0x20: "on the Medusa Temple",
    0x27: "in the Dungeon",
    0x2A: "in the Dungeon",
    0x2C: "in the Dungeon",
}


LocationLookup = StageNameLookup
AreaLookup = StageAreaLookup

rich_presence_conditional_display(byte(0x0019D0) == 55 && byte(0x006CF0) == 0, "Jake is fighting the Huntsgirl 👦🏻⚔️ {0}/3 | 👦🏻🛹 {1}/3 | 👦🏻👟 {2}/3 | 👦🏻❤️ {3}/3 | 👦🏻🎯 {4}/3",
    rich_presence_value("Number", byte(0x007688)),
    rich_presence_value("Number", byte(0x00765C)),
    rich_presence_value("Number", byte(0x007660)),
    rich_presence_value("Number", byte(0x007684)),
    rich_presence_value("Number", byte(0x00768C))
)

rich_presence_conditional_display(byte(0x0019D0) == 55 && byte(0x006CF0) == 1, "Jake is fighting the Huntsgirl 🐲🌀 {0}/3 | 🐲🔥 {1}/3 | 🐲⚡ {2}/3 | 🐲💨 {3}/3 | 🐲⚔️ {4}/3",
    rich_presence_value("Number", byte(0x00766C)),
    rich_presence_value("Number", byte(0x00767C)),
    rich_presence_value("Number", byte(0x007670)),
    rich_presence_value("Number", byte(0x007690)),
    rich_presence_value("Number", byte(0x007658))
)

rich_presence_conditional_display(byte(0x0019D0) == 54 && byte(0x006CF0) == 0, "Jake is fighting the Giant Spider 👦🏻⚔️ {0}/3 | 👦🏻🛹 {1}/3 | 👦🏻👟 {2}/3 | 👦🏻❤️ {3}/3 | 👦🏻🎯 {4}/3",
    rich_presence_value("Number", byte(0x007688)),
    rich_presence_value("Number", byte(0x00765C)),
    rich_presence_value("Number", byte(0x007660)),
    rich_presence_value("Number", byte(0x007684)),
    rich_presence_value("Number", byte(0x00768C))
)

rich_presence_conditional_display(byte(0x0019D0) == 54 && byte(0x006CF0) == 1, "Jake is fighting the Giant Spider 🐲🌀 {0}/3 | 🐲🔥 {1}/3 | 🐲⚡ {2}/3 | 🐲💨 {3}/3 | 🐲⚔️ {4}/3",
    rich_presence_value("Number", byte(0x00766C)),
    rich_presence_value("Number", byte(0x00767C)),
    rich_presence_value("Number", byte(0x007670)),
    rich_presence_value("Number", byte(0x007690)),
    rich_presence_value("Number", byte(0x007658))
)

rich_presence_conditional_display(byte(0x0019D0) == 48 && byte(0x006CF0) == 0, "Jake is fighting the Cyclops 👦🏻⚔️ {0}/3 | 👦🏻🛹 {1}/3 | 👦🏻👟 {2}/3 | 👦🏻❤️ {3}/3 | 👦🏻🎯 {4}/3",
    rich_presence_value("Number", byte(0x007688)),
    rich_presence_value("Number", byte(0x00765C)),
    rich_presence_value("Number", byte(0x007660)),
    rich_presence_value("Number", byte(0x007684)),
    rich_presence_value("Number", byte(0x00768C))
)

rich_presence_conditional_display(byte(0x0019D0) == 48 && byte(0x006CF0) == 1, "Jake is fighting the Cyclops 🐲🌀 {0}/3 | 🐲🔥 {1}/3 | 🐲⚡ {2}/3 | 🐲💨 {3}/3 | 🐲⚔️ {4}/3",
    rich_presence_value("Number", byte(0x00766C)),
    rich_presence_value("Number", byte(0x00767C)),
    rich_presence_value("Number", byte(0x007670)),
    rich_presence_value("Number", byte(0x007690)),
    rich_presence_value("Number", byte(0x007658))
)

rich_presence_conditional_display(byte(0x0019D0) == 53 && byte(0x006CF0) == 0, "Jake is fighting the Medusa 👦🏻⚔️ {0}/3 | 👦🏻🛹 {1}/3 | 👦🏻👟 {2}/3 | 👦🏻❤️ {3}/3 | 👦🏻🎯 {4}/3",
    rich_presence_value("Number", byte(0x007688)),
    rich_presence_value("Number", byte(0x00765C)),
    rich_presence_value("Number", byte(0x007660)),
    rich_presence_value("Number", byte(0x007684)),
    rich_presence_value("Number", byte(0x00768C))
)

rich_presence_conditional_display(byte(0x0019D0) == 53 && byte(0x006CF0) == 1, "Jake is fighting the Medusa 🐲🌀 {0}/3 | 🐲🔥 {1}/3 | 🐲⚡ {2}/3 | 🐲💨 {3}/3 | 🐲⚔️ {4}/3",
    rich_presence_value("Number", byte(0x00766C)),
    rich_presence_value("Number", byte(0x00767C)),
    rich_presence_value("Number", byte(0x007670)),
    rich_presence_value("Number", byte(0x007690)),
    rich_presence_value("Number", byte(0x007658))
)

rich_presence_conditional_display(byte(0x0019D0) == 56 && byte(0x006CF0) == 0, "Jake is rematching the Huntsgirl 👦🏻⚔️ {0}/3 | 👦🏻🛹 {1}/3 | 👦🏻👟 {2}/3 | 👦🏻❤️ {3}/3 | 👦🏻🎯 {4}/3",
    rich_presence_value("Number", byte(0x007688)),
    rich_presence_value("Number", byte(0x00765C)),
    rich_presence_value("Number", byte(0x007660)),
    rich_presence_value("Number", byte(0x007684)),
    rich_presence_value("Number", byte(0x00768C))
)

rich_presence_conditional_display(byte(0x0019D0) == 56 && byte(0x006CF0) == 1, "Jake is rematching the Huntsgirl 🐲🌀 {0}/3 | 🐲🔥 {1}/3 | 🐲⚡ {2}/3 | 🐲💨 {3}/3 | 🐲⚔️ {4}/3",
    rich_presence_value("Number", byte(0x00766C)),
    rich_presence_value("Number", byte(0x00767C)),
    rich_presence_value("Number", byte(0x007670)),
    rich_presence_value("Number", byte(0x007690)),
    rich_presence_value("Number", byte(0x007658))
)

rich_presence_conditional_display(byte(0x0019D0) == 46 && byte(0x006CF0) == 0, "Jake is fighting the Huntsclan 👦🏻⚔️ {0}/3 | 👦🏻🛹 {1}/3 | 👦🏻👟 {2}/3 | 👦🏻❤️ {3}/3 | 👦🏻🎯 {4}/3",
    rich_presence_value("Number", byte(0x007688)),
    rich_presence_value("Number", byte(0x00765C)),
    rich_presence_value("Number", byte(0x007660)),
    rich_presence_value("Number", byte(0x007684)),
    rich_presence_value("Number", byte(0x00768C))
)

rich_presence_conditional_display(byte(0x0019D0) == 46 && byte(0x006CF0) == 1, "Jake is fighting the Huntsclan 🐲🌀 {0}/3 | 🐲🔥 {1}/3 | 🐲⚡ {2}/3 | 🐲💨 {3}/3 | 🐲⚔️ {4}/3",
    rich_presence_value("Number", byte(0x00766C)),
    rich_presence_value("Number", byte(0x00767C)),
    rich_presence_value("Number", byte(0x007670)),
    rich_presence_value("Number", byte(0x007690)),
    rich_presence_value("Number", byte(0x007658))
)

rich_presence_conditional_display(byte(0x0019D0) == 50 && byte(0x006CF0) == 0, "Jake is fighting the Huntsman 👦🏻⚔️ {0}/3 | 👦🏻🛹 {1}/3 | 👦🏻👟 {2}/3 | 👦🏻❤️ {3}/3 | 👦🏻🎯 {4}/3",
    rich_presence_value("Number", byte(0x007688)),
    rich_presence_value("Number", byte(0x00765C)),
    rich_presence_value("Number", byte(0x007660)),
    rich_presence_value("Number", byte(0x007684)),
    rich_presence_value("Number", byte(0x00768C))
)

rich_presence_conditional_display(byte(0x0019D0) == 50 && byte(0x006CF0) == 1, "Jake is fighting the Huntsman 🐲🌀 {0}/3 | 🐲🔥 {1}/3 | 🐲⚡ {2}/3 | 🐲💨 {3}/3 | 🐲⚔️ {4}/3",
    rich_presence_value("Number", byte(0x00766C)),
    rich_presence_value("Number", byte(0x00767C)),
    rich_presence_value("Number", byte(0x007670)),
    rich_presence_value("Number", byte(0x007690)),
    rich_presence_value("Number", byte(0x007658))
)

rich_presence_conditional_display(byte(0x006CF0) == 0 && byte(0x0019D0) >= 0 &&
    ((byte(0x0019D0) == 11) ||
     (byte(0x0019D0) == 14) ||
     (byte(0x0019D0) == 15) ||
     (byte(0x0019D0) == 18) ||
     (byte(0x0019D0) == 20) ||
     (byte(0x0019D0) == 23) ||
     (byte(0x0019D0) == 25) ||
     (byte(0x0019D0) == 28) ||
     (byte(0x0019D0) == 30) ||
     (byte(0x0019D0) == 35) ||
     (byte(0x0019D0) == 37) ||
     (byte(0x0019D0) == 32) ||
     (byte(0x0019D0) == 39) ||
     (byte(0x0019D0) == 42) ||
     (byte(0x0019D0) == 44)), "Jake is currently {0} [{1}] 👦🏻⚔️ {2}/3 | 👦🏻🛹 {3}/3 | 👦🏻👟 {4}/3 | 👦🏻❤️ {5}/3 | 👦🏻🎯 {6}/3",
    rich_presence_lookup("Area", byte(0x0019D0), AreaLookup),
    rich_presence_lookup("Location", byte(0x0019D0), LocationLookup),
    rich_presence_value("Number", byte(0x007688)),
    rich_presence_value("Number", byte(0x00765C)),
    rich_presence_value("Number", byte(0x007660)),
    rich_presence_value("Number", byte(0x007684)),
    rich_presence_value("Number", byte(0x00768C))
)

rich_presence_conditional_display(byte(0x006CF0) == 1 && byte(0x0019D0) >= 0 &&
    ((byte(0x0019D0) == 11) ||
     (byte(0x0019D0) == 14) ||
     (byte(0x0019D0) == 15) ||
     (byte(0x0019D0) == 18) ||
     (byte(0x0019D0) == 20) ||
     (byte(0x0019D0) == 23) ||
     (byte(0x0019D0) == 25) ||
     (byte(0x0019D0) == 28) ||
     (byte(0x0019D0) == 30) ||
     (byte(0x0019D0) == 35) ||
     (byte(0x0019D0) == 37) ||
     (byte(0x0019D0) == 32) ||
     (byte(0x0019D0) == 39) ||
     (byte(0x0019D0) == 42) ||
     (byte(0x0019D0) == 44)), "Jake is currently {0} [{1}] 🐲🌀 {2}/3 | 🐲🔥 {3}/3 | 🐲⚡ {4}/3 | 🐲💨 {5}/3 | 🐲⚔️ {6}/3",
    rich_presence_lookup("Area", byte(0x0019D0), AreaLookup),
    rich_presence_lookup("Location", byte(0x0019D0), LocationLookup),
    rich_presence_value("Number", byte(0x00766C)),
    rich_presence_value("Number", byte(0x00767C)),
    rich_presence_value("Number", byte(0x007670)),
    rich_presence_value("Number", byte(0x007690)),
    rich_presence_value("Number", byte(0x007658))
)

rich_presence_display("Not currently in a stage")
