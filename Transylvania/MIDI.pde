import themidibus.*;

public class MickeyMIDI
{
  private class noteoffstruct
  {
   int ms;
   int channel;
   int note;
   noteoffstruct(int ms, int channel, int note)
   {
     this.ms = ms;
     this.channel = channel;
     this.note = note;
   }
  };
  private noteoffstruct[] noteoffs = new noteoffstruct[64];
  private int noteoffCount = 0;
  
  private void scheduleNoteOff(int channel, int note, int duration)
  {
    if (noteoffCount == 64)
      return;
    for (int ix = 0; ix < noteoffCount; ix++)
    {
      if (noteoffs[ix].channel == channel && noteoffs[ix].note == note)
      {
        noteoffs[ix].ms = millis() + duration;
        return;
      }
    }
    noteoffs[noteoffCount++] = new noteoffstruct(millis() + duration, channel, note);
  }

  public MidiBus myBus;

  public MickeyMIDI()
  {
      
  }

  public void begin()
  {
    myBus = new MidiBus(this, -1, "Microsoft GS Wavetable Synth");
  }

  public void begin(String deviceNaame)
  {
    myBus = new MidiBus(this, -1, deviceNaame);
  }

  public void list()
  {
    MidiBus.list();
  }
  
  public void processNoteOffs()
  {
    if (noteoffCount == 0)
      return;
    for (int ix = 0; ix < noteoffCount; ix++)
    {
      if (millis() >= noteoffs[ix].ms)
      {
        myBus.sendNoteOff(noteoffs[ix].channel, noteoffs[ix].note, 0);
        noteoffCount--;
        if (noteoffCount != 0)
          noteoffs[ix] = noteoffs[noteoffCount];
      }
    }
  }

  public void playNote(int channel, int note, int velocity, int duration)
  {
    myBus.sendNoteOn(channel, note, velocity);
    scheduleNoteOff(channel, note, duration);
  }

  public void playNote(int channel, MIDInote note, int velocity, int duration)
  {
    myBus.sendNoteOn(channel, note.ToInt(), velocity);
    scheduleNoteOff(channel, note.ToInt(), duration);
  }
  
  public void playDrum(MIDIdrum drum, int velocity)
  {
    myBus.sendNoteOn(9, drum.ToInt(), velocity);
    scheduleNoteOff(9, drum.ToInt(), 1000);
  }
  
  public void playDrum(MIDIdrum drum, int velocity, int duration)
  {
    myBus.sendNoteOn(9, drum.ToInt(), velocity);
    scheduleNoteOff(9, drum.ToInt(), duration);
  }
  
  public void setInstrument(int channel, MIDIinstrument inst)
  {
    myBus.sendMessage(0xC0 | channel, inst.ToInt());
  }

};

MickeyMIDI midi = new MickeyMIDI();


public enum MIDIinstrument
{
  AcousticGrandPiano(0),
  BrightAcousticPiano(1),
  ElectricGrandPiano(2),
  HonkyTonkPiano(3),
  ElectricPiano1(4),
  ElectricPiano2(5),
  Harpsichord(6),
  Clavi(7),
  Celesta(8),
  Glockenspiel(9),
  MusicBox(10),
  Vibraphone(11),
  Marimba(12),
  Xylophone(13),
  TubularBells(14),
  Dulcimer(15),
  DrawbarOrgan(16),
  PercussiveOrgan(17),
  RockOrgan(18),
  ChurchOrgan(19),
  ReedOrgan(20),
  Accordion(21),
  Harmonica(22),
  TangoAccordion(23),
  AcousticGuitarNylon(24),
  AcousticGuitarSteel(25),
  ElectricGuitarJazz(26),
  ElectricGuitarClean(27),
  ElectricGuitarMuted(28),
  OverdrivenGuitar(29),
  DistortionGuitar(30),
  Guitarharmonics(31),
  AcousticBass(32),
  ElectricBassFinger(33),
  ElectricBassPick(34),
  FretlessBass(35),
  SlapBass1(36),
  SlapBass2(37),
  SynthBass1(38),
  SynthBass2(39),
  Violin(40),
  Viola(41),
  Cello(42),
  Contrabass(43),
  TremoloStrings(44),
  PizzicatoStrings(45),
  OrchestralHarp(46),
  Timpani(47),
  StringEnsemble1(48),
  StringEnsemble2(49),
  SynthStrings1(50),
  SynthStrings2(51),
  ChoirAahs(52),
  VoiceOohs(53),
  SynthVoice(54),
  OrchestraHit(55),
  Trumpet(56),
  Trombone(57),
  Tuba(58),
  MutedTrumpet(59),
  FrenchHorn(60),
  BrassSection(61),
  SynthBrass1(62),
  SynthBrass2(63),
  SopranoSax(64),
  AltoSax(65),
  TenorSax(66),
  BaritoneSax(67),
  Oboe(68),
  EnglishHorn(69),
  Bassoon(70),
  Clarinet(71),
  Piccolo(72),
  Flute(73),
  Recorder(74),
  PanFlute(75),
  BlownBottle(76),
  Shakuhachi(77),
  Whistle(78),
  Ocarina(79),
  Lead1square(80),
  Lead2sawtooth(81),
  Lead3calliope(82),
  Lead4chiff(83),
  Lead5charang(84),
  Lead6voice(85),
  Lead7fifths(86),
  Lead8bassnlead(87),
  Pad1newage(88),
  Pad2warm(89),
  Pad3polysynth(90),
  Pad4choir(91),
  Pad5bowed(92),
  Pad6metallic(93),
  Pad7halo(94),
  Pad8sweep(95),
  FX1rain(96),
  FX2soundtrack(97),
  FX3crystal(98),
  FX4atmosphere(99),
  FX5brightness(100),
  FX6goblins(101),
  FX7echoes(102),
  FX8scifi(103),
  Sitar(104),
  Banjo(105),
  Shamisen(106),
  Koto(107),
  Kalimba(108),
  Bagpipe(109),
  Fiddle(110),
  Shanai(111),
  TinkleBell(112),
  Agogo(113),
  SteelDrums(114),
  Woodblock(115),
  TaikoDrum(116),
  MelodicTom(117),
  SynthDrum(118),
  ReverseCymbal(119),
  GuitarFretNoise(120),
  BreathNoise(121),
  Seashore(122),
  BirdTweet(123),
  TelephoneRing(124),
  Helicopter(125),
  Applause(126),
  Gunshot(127);

  private int value;
  private MIDIinstrument(int value)
  {
    this.value = value;
  }
  public int ToInt()
  {  
    return value;
  }
};


public enum MIDIdrum {
  AcousticBassDrum(35),
  BassDrum1(36),
  SideStick(37),
  AcousticSnare(38),
  HandClap(39),
  ElectricSnare(40),
  LowFloorTom(41),
  ClosedHiHat(42),
  HighFloorTom(43),
  PedalHiHat(44),
  LowTom(45),
  OpenHiHat(46),
  LowMidTom(47),
  HiMidTom(48),
  CrashCymbal1(49),
  HighTom(50),
  RideCymbal1(51),
  ChineseCymbal(52),
  RideBell(53),
  Tambourine(54),
  SplashCymbal(55),
  Cowbell(56),
  CrashCymbal2(57),
  Vibraslap(58),
  RideCymbal2(59),
  HiBongo(60),
  LowBongo(61),
  MuteHiConga(62),
  OpenHiConga(63),
  LowConga(64),
  HighTimbale(65),
  LowTimbale(66),
  HighAgogo(67),
  LowAgogo(68),
  Cabasa(69),
  Maracas(70),
  ShortWhistle(71),
  LongWhistle(72),
  ShortGuiro(73),
  LongGuiro(74),
  Claves(75),
  HiWoodBlock(76),
  LowWoodBlock(77),
  MuteCuica(78),
  OpenCuica(79),
  MuteTriangle(80),
  OpenTriangle(81);

  private int value;
  private MIDIdrum(int value)
  {
    this.value = value;
  }
  public int ToInt()
  {  
    return value;
  }
};


public enum MIDInote {
  C0(0),  Cs0(1),  D0(2),  Ds0(3),  E0(4),  F0(5),  Fs0(6),  G0(7),  Gs0(8),  A0(9),  As0(10),  B0(11),
  C1(12),  Cs1(13),  D1(14),  Ds1(15),  E1(16),  F1(17),  Fs1(18),  G1(19),  Gs1(20),  A1(21),  As1(22),  B1(23),
  C2(24),  Cs2(25),  D2(26),  Ds2(27),  E2(28),  F2(29),  Fs2(30),  G2(31),  Gs2(32),  A2(33),  As2(34),  B2(35),
  C3(36),  Cs3(37),  D3(38),  Ds3(39),  E3(40),  F3(41),  Fs3(42),  G3(43),  Gs3(44),  A3(45),  As3(46),  B3(47),
  C4(48),  Cs4(49),  D4(50),  Ds4(51),  E4(52),  F4(53),  Fs4(54),  G4(55),  Gs4(56),  A4(57),  As4(58),  B4(59),
  C5(60),  Cs5(61),  D5(62),  Ds5(63),  E5(64),  F5(65),  Fs5(66),  G5(67),  Gs5(68),  A5(69),  As5(70),  B5(71),
  C6(72),  Cs6(73),  D6(74),  Ds6(75),  E6(76),  F6(77),  Fs6(78),  G6(79),  Gs6(80),  A6(81),  As6(82),  B6(83),
  C7(84),  Cs7(85),  D7(86),  Ds7(87),  E7(88),  F7(89),  Fs7(90),  G7(91),  Gs7(92),  A7(93),  As7(94),  B7(95),
  C8(96),  Cs8(97),  D8(98),  Ds8(99),  E8(100),  F8(101),  Fs8(102),  G8(103),  Gs8(104),  A8(105),  As8(106),  B8(107),
  C9(108),  Cs9(109),  D9(110),  Ds9(111),  E9(112),  F9(113),  Fs9(114),  G9(115),  Gs9(116),  A9(117),  As9(118),  B9(119),
  C10(120),  Cs10(121),  D10(122),  Ds10(123),  E10(124),  F10(125),  Fs10(126),  G10(127);        

  private int value;
  private MIDInote(int value)
  {
    this.value = value;
  }
  public int ToInt()
  {  
    return value;
  }
};