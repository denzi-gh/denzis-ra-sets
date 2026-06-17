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
function FuDogJumpInAvailable() => byte(0x006BD8)
function GrandpaJumpInAvailable() => byte(0x006BD9)
function TrixieSpudJumpInAvailable() => byte(0x006BDA)
function DragonMeter() => byte(0x00707E)
function EnemiesOnScreen() => byte(0x007470)
function EnemiesDespawned() => byte(0x0074C0)
function DragonAttackLevel() => byte(0x007658)
function DragonDrainLevel() => byte(0x00766c)
function DragonChargeLevel() => byte(0x007670)
function DragonFireLevel() => byte(0x00767c)
function DragonSpeedLevel() => byte(0x007690)
function JakeAttackLevel() => byte(0x007688)
function JakeSkateLevel() => byte(0x00765c)
function JakeSpeedLevel() => byte(0x007660)
function JakeHealthLevel() => byte(0x007684)
function JakeFocusLevel() => byte(0x00768c)

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
JAKE_ACTION_JUMPING = 0
JAKE_ACTION_ON_FEET = 1
ON_SKATEBOARD = 2
ON_SKATEBOARD_AIRBORNE = 3
CAMERA_UNLOCKED = 0
CAMERA_LOCKED = 1
PAUSE_STATE_UNPAUSED = 0x00
PAUSE_STATE_PAUSED = 0x01
JUMP_IN_AVAILABLE = 0x01
JUMP_IN_UNAVAILABLE = 0x00
DRAGON_METER_FULL = 0x32
JAKE_FULL_HEALTH = 74
MAX_ABILITY_LEVEL = 0x03
PRE_MAX_ABILITY_LEVEL = 0x02
JAKE_ABILITY_MAX_TOTAL = 0x0F
DRAGON_ABILITY_MAX_TOTAL = 0x0F
ALL_ABILITY_MAX_TOTAL = 0x1E
DRAGON_UP_ENEMY_TARGET = 30
GOOD_BOY_FU_DOG_ENEMY_TARGET = 15
CHEESEBURGER_COMEBACK_WAVE_TARGET = 3
GRANDPA_MASTER_ENEMY_TARGET = 2
HUNTSCLAN_CLONES_OVERFLOW_TARGET = 150

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
function EnteredScreen(screen) => IsScreen(screen) && !WasScreen(screen)

// Checks if the Player has entered a Jump In Cutscene
function IsJumpInScreen() => IsScreen(SCREEN_JUMP_IN_CUTSCENE) || IsScreen(SCREEN_JUMP_IN_RETURN)
function FuDogJumpInUsed() => FuDogJumpInAvailable() == JUMP_IN_UNAVAILABLE
function GrandpaJumpInUsedDelta() => GrandpaJumpInAvailable() == JUMP_IN_UNAVAILABLE && prev(GrandpaJumpInAvailable()) == JUMP_IN_AVAILABLE
function TrixieSpudJumpInUsed() => TrixieSpudJumpInAvailable() == JUMP_IN_UNAVAILABLE
function TrixieSpudJumpInUsedDelta() => TrixieSpudJumpInAvailable() == JUMP_IN_UNAVAILABLE && prev(TrixieSpudJumpInAvailable()) == JUMP_IN_AVAILABLE
function DragonMeterFilledDelta() => DragonMeter() == DRAGON_METER_FULL && prev(DragonMeter()) < DRAGON_METER_FULL
function DragonMeterFull() => DragonMeter() == DRAGON_METER_FULL

// PLAYER FORM HELPER
function IsJakeForm() => PlayerForm() == FORM_JAKE
function IsDragonForm() => PlayerForm() == FORM_DRAGON
function EnteredDragonForm() => PlayerForm() > prev(PlayerForm())
function DragonTransformationEnded() => PlayerForm() < prev(PlayerForm())
function IsVictoryPoseActive() => VictoryPose() == VICTORY_POSE_ACTIVE
function WasVictoryPoseActive() => prev(VictoryPose()) == VICTORY_POSE_ACTIVE
function IsInStage(stage) => IsScreen(stage)
function LeftStage(stage) => WasScreen(stage) && ScreenId() != stage
function JakeIsFullHealth() => JakeHealth() == JAKE_FULL_HEALTH

function TookDamage() => JakeHealth() < JAKE_FULL_HEALTH
function TookDamageDelta() => JakeHealth() < prev(JakeHealth())
function HealedToFullHealthDelta() => JakeIsFullHealth() && prev(JakeHealth()) < JAKE_FULL_HEALTH
function IsJumping() => isOnSkateboard() == JAKE_ACTION_JUMPING
function StartedJumping() => isOnSkateboard() == JAKE_ACTION_JUMPING && prev(isOnSkateboard()) != JAKE_ACTION_JUMPING
function IsOnFeet() => isOnSkateboard() == JAKE_ACTION_ON_FEET
function IsSkateboardAirborne() => isOnSkateboard() == ON_SKATEBOARD_AIRBORNE
function StartedSkateboardAirborne() => isOnSkateboard() == ON_SKATEBOARD_AIRBORNE && prev(isOnSkateboard()) != ON_SKATEBOARD_AIRBORNE
function IsSkateboarding() => isOnSkateboard() == ON_SKATEBOARD || isOnSkateboard() == ON_SKATEBOARD_AIRBORNE
function IsCameraUnlocked() => CameraLock() == CAMERA_UNLOCKED
function IsCameraLocked() => CameraLock() == CAMERA_LOCKED
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
function AnyRegularStageClearCandidate() => any_of(RegularStageIds, stage => StageClearCandidate(stage))
function LeftJumpInReturn() => WasScreen(SCREEN_JUMP_IN_RETURN) && ScreenId() != SCREEN_JUMP_IN_RETURN
function LeftBossAttempt(stage) => WasScreen(stage) &&
                                   ScreenId() != stage &&
                                   ScreenId() != SCREEN_JUMP_IN_CUTSCENE &&
                                   ScreenId() != SCREEN_JUMP_IN_RETURN
function LeftBossAttemptWithoutClear(stage) => LeftBossAttempt(stage) &&
                                               !IsVictoryPoseActive() &&
                                               !WasVictoryPoseActive()
function BossStageClearHitReset(stage) => EnteredScreen(stage) ||
                                          LeftBossAttemptWithoutClear(stage)
function BossStageClearCandidate(stage) => never(BossStageClearHitReset(stage)) &&
                                           once(IsScreen(stage)) &&
                                           (LeftStage(stage) || LeftJumpInReturn()) &&
                                           (IsVictoryPoseActive() || WasVictoryPoseActive())

// TIMER HELPER
function StageTimer() => StageTimerHigh() * 65536 + StageTimerLow()
function BossLeaderboardStart(stage) => EnteredScreen(stage) && IsUnpaused()
function BossLeaderboardCancel(stage) => IsJumpInScreen() || !IsScreen(stage)
function BossLeaderboardTimerRunning() => IsUnpaused()

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
function LeftHuntsclanClonesAttempt() => LeftBossAttempt(BOSS_HUNTSCLAN_CLONES)

//ENEMY HELPER
function EnemyDefeatedDelta() => EnemiesDespawned() > prev(EnemiesDespawned())
function EnemyWaveActive() => EnemiesOnScreen() > 0
function EnemyWaveClearedDelta() => EnemiesOnScreen() == 0 && prev(EnemiesOnScreen()) > 0

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
function HuntsmanFinalPhaseDefeatedDelta() => any_of(HUNTSMAN_HP_ADDRESSES, address =>
    never(!IsScreen(BOSS_HUNTSMAN)) &&
    once(HuntsmanHp(address) == HUNTSMAN_FINAL_PHASE_HP) &&
    HuntsmanHp(address) == HUNTSMAN_DEFEATED_HP &&
    prev(HuntsmanHp(address)) == HUNTSMAN_LAST_HP
)

//ABILITY HELPER
function DragonAttackLevelMaxedDelta() => DragonAttackLevel() == MAX_ABILITY_LEVEL && prev(DragonAttackLevel()) == PRE_MAX_ABILITY_LEVEL
function DragonDrainLevelMaxedDelta() => DragonDrainLevel() == MAX_ABILITY_LEVEL && prev(DragonDrainLevel()) == PRE_MAX_ABILITY_LEVEL
function DragonChargeLevelMaxedDelta() => DragonChargeLevel() == MAX_ABILITY_LEVEL && prev(DragonChargeLevel()) == PRE_MAX_ABILITY_LEVEL
function DragonFireLevelMaxedDelta() => DragonFireLevel() == MAX_ABILITY_LEVEL && prev(DragonFireLevel()) == PRE_MAX_ABILITY_LEVEL
function DragonSpeedLevelMaxedDelta() => DragonSpeedLevel() == MAX_ABILITY_LEVEL && prev(DragonSpeedLevel()) == PRE_MAX_ABILITY_LEVEL

function JakeAttackLevelMaxedDelta() => JakeAttackLevel() == MAX_ABILITY_LEVEL && prev(JakeAttackLevel()) == PRE_MAX_ABILITY_LEVEL
function JakeSkateLevelMaxedDelta() => JakeSkateLevel() == MAX_ABILITY_LEVEL && prev(JakeSkateLevel()) == PRE_MAX_ABILITY_LEVEL
function JakeSpeedLevelMaxedDelta() => JakeSpeedLevel() == MAX_ABILITY_LEVEL && prev(JakeSpeedLevel()) == PRE_MAX_ABILITY_LEVEL
function JakeHealthLevelMaxedDelta() => JakeHealthLevel() == MAX_ABILITY_LEVEL && prev(JakeHealthLevel()) == PRE_MAX_ABILITY_LEVEL
function JakeFocusLevelMaxedDelta() => JakeFocusLevel() == MAX_ABILITY_LEVEL && prev(JakeFocusLevel()) == PRE_MAX_ABILITY_LEVEL

function DragonAbilityLevelTotal() => DragonAttackLevel() + DragonDrainLevel() + DragonChargeLevel() + DragonFireLevel() + DragonSpeedLevel()
function JakeAbilityLevelTotal() => JakeAttackLevel() + JakeSkateLevel() + JakeSpeedLevel() + JakeHealthLevel() + JakeFocusLevel()
function AllAbilityLevelTotal() => DragonAbilityLevelTotal() + JakeAbilityLevelTotal()




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
    trigger = never(BossStageClearHitReset(BOSS_GIANT_SPIDER)) &&
              once(GiantSpiderDefeatedDelta()) &&
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
    title = "Grounded at Altitude",
    description = "Clear Stage 3-3 without Dragon Mode and without ever Jumping",
    points = 10,
    type = "missable",
    trigger = never(IsScreen(STAGE_3_3) && IsCameraLocked()) &&
              once(IsScreen(STAGE_3_3) && IsCameraUnlocked() && IsOnFeet()) &&
              disable_when(IsScreen(STAGE_3_3) && IsCameraUnlocked() && IsDragonForm(),
                           IsScreen(STAGE_3_3) && IsCameraLocked()) &&
              disable_when(IsScreen(STAGE_3_3) && IsCameraUnlocked() && StartedJumping(),
                           IsScreen(STAGE_3_3) && IsCameraLocked()) &&
              disable_when(IsScreen(STAGE_3_3) && IsCameraUnlocked() && StartedSkateboardAirborne(),
                           IsScreen(STAGE_3_3) && IsCameraLocked()) &&
              trigger_when(StageClearCandidate(STAGE_3_3))
)

achievement(
    title = "Eye on the Bridge",
    description = "Defeat the Cyclops and complete World 3",
    points = 10,
    type = "progression",
    trigger = never(BossStageClearHitReset(BOSS_CYCLOPS)) &&
              once(CyclopsDefeatedDelta()) &&
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
              disable_when(repeated(CYCLOPS_TIME_LIMIT, CyclopsTimerRunning()), !IsScreen(BOSS_CYCLOPS)) &&
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
    title = "Dragon vs. Snake",
    description = "Defeat Giant Medusa while in Dragon Form, without Jump Ins and without taking damage",
    points = 25,
    type = "missable",
    trigger = once(IsScreen(BOSS_MEDUSA)) &&
              once(GiantMedusaFullHP()) &&
              IsDragonForm() &&
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
    description = "Clear Stage 5-2 as Jake descends into the darkness",
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
    trigger = never(EnteredScreen(BOSS_HUNTSCLAN_CLONES) || LeftBossAttempt(BOSS_HUNTSCLAN_CLONES)) &&
              once(IsScreen(BOSS_HUNTSCLAN_CLONES)) &&
              disable_when(IsJumpInScreen(), LeftHuntsclanClonesAttempt()) &&
              disable_when(repeated(HUNTSCLAN_CLONES_TIME_LIMIT, HuntsclanClonesTimerRunning()), LeftHuntsclanClonesAttempt()) &&
              trigger_when(CloneTankDefeatedDelta())
)

achievement(
    title = "Clone Control",
    description = "Defeat 150 Huntsclan Clones before destroying the tank without getting hit more than three times",
    points = 25,
    type = "missable",
    trigger = never(LeftHuntsclanClonesAttempt()) &&
              once(IsScreen(BOSS_HUNTSCLAN_CLONES)) &&
              disable_when(repeated(4, IsScreen(BOSS_HUNTSCLAN_CLONES) && TookDamageDelta()), LeftHuntsclanClonesAttempt()) &&
              measured(repeated(HUNTSCLAN_CLONES_OVERFLOW_TARGET, IsScreen(BOSS_HUNTSCLAN_CLONES) && EnemyDefeatedDelta())) &&
              trigger_when(CloneTankDefeatedDelta())
)

// HUNTSMAN FINAL BOSS ACHIEVEMENTS

achievement(
    title = "Take That, Huntsfool!",
    description = "Defeat the Huntsman",
    points = 25,
    trigger = BossStageClearCandidate(BOSS_HUNTSMAN)
)

achievement(
    title = "Huntsman, More Like HuntsCAN'T",
    description = "Defeat the Huntsman without using Jump Ins and without taking damage",
    points = 50,
    type = "missable",
    trigger = once(IsScreen(BOSS_HUNTSMAN)) &&
              never(TookDamage()) &&
              never(IsJumpInScreen()) &&
              // Huntsman reaches 0 multiple times and regenerates due to Phases, helper checks if Health was 0x08 (Last Phase Health) once
              trigger_when(HuntsmanFinalPhaseDefeatedDelta())
)

// MISC ACHIEVEMENTS

achievement(
    title = "Dragon Up!",
    description = "Enter Dragon Mode and defeat 30 enemies before the transformation ends",
    points = 5,
    trigger = once(EnteredDragonForm()) &&
              never(DragonTransformationEnded()) &&
              measured(repeated(DRAGON_UP_ENEMY_TARGET, IsDragonForm() && EnemyDefeatedDelta()))
)

achievement(
    title = "Good Boy, Fu Dog",
    description = "Use Fu Dog's Jump In to fill the Focus meter, Dragon Up, and defeat 15 enemies before the transformation ends",
    points = 5,
    trigger = once(IsScreen(SCREEN_JUMP_IN_RETURN)) &&
              once(FuDogJumpInUsed()) &&
              once(DragonMeterFull()) &&
              once(PlayerForm() >= prev(PlayerForm())) &&
              never(DragonTransformationEnded()) &&
              repeated(GOOD_BOY_FU_DOG_ENEMY_TARGET, IsDragonForm() && EnemyDefeatedDelta())
)

achievement(
    title = "Cheeseburger Comeback",
    description = "Use Trixie & Spud’s Jump In, heal to full health, then clear three enemy waves without taking another hit",
    points = 5,
    trigger = once(IsScreen(SCREEN_JUMP_IN_RETURN)) &&
              once(TrixieSpudJumpInUsedDelta()) &&
              once(HealedToFullHealthDelta()) &&
              never(TookDamageDelta()) &&
              measured(repeated(CHEESEBURGER_COMEBACK_WAVE_TARGET, IsScreen(SCREEN_JUMP_IN_RETURN) && TrixieSpudJumpInUsed() && JakeIsFullHealth() && EnemyWaveClearedDelta()))
)

achievement(
    title = "With Grandpa the Master",
    description = "Use Grandpa’s Jump In to defeat 5 enemies with his fireball attack",
    points = 5,
    trigger = once(GrandpaJumpInUsedDelta()) &&
              once(IsScreen(SCREEN_JUMP_IN_RETURN)) &&
              never(LeftJumpInReturn() && EnemyWaveActive()) &&
              measured(repeated(GRANDPA_MASTER_ENEMY_TARGET, IsScreen(SCREEN_JUMP_IN_RETURN) && EnemyDefeatedDelta()))
)

achievement(
    title = "He's Cool, He's Hot Like a Frozen Sun",
    description = "Clear any non-boss stage without taking damage and without using Dragon Mode",
    points = 10,
    trigger = once(any_of(RegularStageIds, stage => IsScreen(stage))) &&
              never(TookDamage()) &&
              never(IsDragonForm()) &&
              AnyRegularStageClearCandidate()
)

//Ability Achievements

achievement(
    title = "His Skills Are Getting Faster",
    description = "Max out any Ability for the first time",
    points = 3,
    trigger = DragonAttackLevelMaxedDelta() ||
              DragonDrainLevelMaxedDelta() ||
              DragonChargeLevelMaxedDelta() ||
              DragonFireLevelMaxedDelta() ||
              DragonSpeedLevelMaxedDelta() ||
              JakeAttackLevelMaxedDelta() ||
              JakeSkateLevelMaxedDelta() ||
              JakeSpeedLevelMaxedDelta() ||
              JakeHealthLevelMaxedDelta() ||
              JakeFocusLevelMaxedDelta()
)

achievement(
    title = "Jake of All Trades",
    description = "Max out all of Jake's Abilities",
    points = 10,
    trigger = (JakeAttackLevelMaxedDelta() ||
               JakeSkateLevelMaxedDelta() ||
               JakeSpeedLevelMaxedDelta() ||
               JakeHealthLevelMaxedDelta() ||
               JakeFocusLevelMaxedDelta()) &&
              measured(JakeAbilityLevelTotal() == JAKE_ABILITY_MAX_TOTAL)
)

achievement(
    title = "Dragon Power, Dragon Teeth, Dragon Tail, Burning Dragon Fire",
    description = "Max out all Dragon Abilities",
    points = 10,
    trigger = (DragonAttackLevelMaxedDelta() ||
               DragonDrainLevelMaxedDelta() ||
               DragonChargeLevelMaxedDelta() ||
               DragonFireLevelMaxedDelta() ||
               DragonSpeedLevelMaxedDelta()) &&
              measured(DragonAbilityLevelTotal() == DRAGON_ABILITY_MAX_TOTAL)
)

achievement(
    title = "He's the AMERICAN DRAGOON",
    description = "Max out all Abilities",
    points = 25,
    trigger = (DragonAttackLevelMaxedDelta() ||
               DragonDrainLevelMaxedDelta() ||
               DragonChargeLevelMaxedDelta() ||
               DragonFireLevelMaxedDelta() ||
               DragonSpeedLevelMaxedDelta() ||
               JakeAttackLevelMaxedDelta() ||
               JakeSkateLevelMaxedDelta() ||
               JakeSpeedLevelMaxedDelta() ||
               JakeHealthLevelMaxedDelta() ||
               JakeFocusLevelMaxedDelta()) &&
              measured(AllAbilityLevelTotal() == ALL_ABILITY_MAX_TOTAL)
)

// LEADERBOARDS

leaderboard(
    title = "Huntsgirl Boss Stage Speedrun",
    description = "Defeat the Huntsgirl as fast as possible without using Jump-ins",
    start = BossLeaderboardStart(BOSS_HUNTSGIRL),
    cancel = BossLeaderboardCancel(BOSS_HUNTSGIRL),
    submit = IsScreen(BOSS_HUNTSGIRL) && HuntsgirlDefeatedDelta(),
    value = measured(repeated(0, BossLeaderboardTimerRunning())),
    format = "FRAMES",
    lower_is_better = true
)

leaderboard(
    title = "Giant Spider Boss Stage Speedrun",
    description = "Defeat the Giant Spider as fast as possible without using Jump-ins",
    start = BossLeaderboardStart(BOSS_GIANT_SPIDER),
    cancel = BossLeaderboardCancel(BOSS_GIANT_SPIDER),
    submit = IsScreen(BOSS_GIANT_SPIDER) && GiantSpiderDefeatedDelta(),
    value = measured(repeated(0, BossLeaderboardTimerRunning())),
    format = "FRAMES",
    lower_is_better = true
)

leaderboard(
    title = "Cyclops Boss Stage Speedrun",
    description = "Defeat the Cyclops as fast as possible without using Jump-ins",
    start = BossLeaderboardStart(BOSS_CYCLOPS),
    cancel = BossLeaderboardCancel(BOSS_CYCLOPS),
    submit = IsScreen(BOSS_CYCLOPS) && CyclopsDefeatedDelta(),
    value = measured(repeated(0, BossLeaderboardTimerRunning())),
    format = "FRAMES",
    lower_is_better = true
)

leaderboard(
    title = "Giant Medusa Boss Stage Speedrun",
    description = "Defeat the Giant Medusa as fast as possible without using Jump-ins",
    start = BossLeaderboardStart(BOSS_MEDUSA),
    cancel = BossLeaderboardCancel(BOSS_MEDUSA),
    submit = IsScreen(BOSS_MEDUSA) && GiantMedusaDefeatedDelta(),
    value = measured(repeated(0, BossLeaderboardTimerRunning())),
    format = "FRAMES",
    lower_is_better = true
)

leaderboard(
    title = "Huntsgirl Rematch Speedrun",
    description = "Defeat the Huntsgirl again as fast as possible without using Jump-ins",
    start = BossLeaderboardStart(BOSS_HUNTSGIRL_REMATCH),
    cancel = BossLeaderboardCancel(BOSS_HUNTSGIRL_REMATCH),
    submit = IsScreen(BOSS_HUNTSGIRL_REMATCH) && HuntsgirlDefeatedDelta(),
    value = measured(repeated(0, BossLeaderboardTimerRunning())),
    format = "FRAMES",
    lower_is_better = true
)

leaderboard(
    title = "Huntsman Clones Boss Stage Speedrun",
    description = "Defeat the Huntsman Clones as fast as possible without using Jump-ins",
    start = BossLeaderboardStart(BOSS_HUNTSCLAN_CLONES),
    cancel = BossLeaderboardCancel(BOSS_HUNTSCLAN_CLONES),
    submit = IsScreen(BOSS_HUNTSCLAN_CLONES) && CloneTankDefeatedDelta(),
    value = measured(repeated(0, BossLeaderboardTimerRunning())),
    format = "FRAMES",
    lower_is_better = true
)

leaderboard(
    title = "Huntsman Boss Stage Speedrun",
    description = "Defeat the Huntsman as fast as possible without using Jump-ins",
    start = BossLeaderboardStart(BOSS_HUNTSMAN),
    cancel = BossLeaderboardCancel(BOSS_HUNTSMAN),
    submit = IsScreen(BOSS_HUNTSMAN) && HuntsmanFinalPhaseDefeatedDelta(),
    value = measured(repeated(0, BossLeaderboardTimerRunning())),
    format = "FRAMES",
    lower_is_better = true
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
