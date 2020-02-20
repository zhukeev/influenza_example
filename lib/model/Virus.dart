import 'package:flutter/foundation.dart';

class Virus {
  String name;
  String image;
  String symptoms;
  String duration;
  String frequency;
  String death;
  String description;
  List<String> treatment;
  List<String> proteins;

  Virus(
      {@required this.name,
      @required this.image,
      this.symptoms,
      this.duration,
      this.frequency,
      this.death,
      this.description,
      this.treatment,
      this.proteins});
}

final viruses = [
  Virus(
      name: "Infuenza",
      image: 'assets/images/Influenza_j14.png',
      symptoms:
          'high fever, runny nose, sore throat, muscle and joint pain, headache, coughing,',
      proteins: [
        'RNA',
        'Hemagglutinin',
        'neuraminidase',
        'Protein Evelope',
        'Lipid Envelope'
      ],
      duration: '~ 1 week',
      frequency: '3-5 million per year',
      death: '~ 375,000 per year',
      description:
          'Influenza, commonly known as "the flu", is an infectious disease caused by an influenza virus. Symptoms can be mild to severe. The most common symptoms include: high fever, runny nose, sore throat, muscle and joint pain, headache, coughing, and feeling tired. These symptoms typically begin two days after exposure to the virus and most last less than a week.',
      treatment: ['Anitviral drugs', 'Rest', 'Fluids']),
  Virus(
      name: "Cold Virus",
      image: 'assets/images/influenza_h01.png',
      symptoms: 'Cough, sore throat, runny nose, fever.',
      proteins: [
        'RNA',
        'Hemagglutinin',
        'neuraminidase',
        'Protein Evelope',
        'Lipid Envelope'
      ],
      duration: '~ 1 week',
      frequency: '3-5 million per year',
      death: '~ 375,000 per year',
      description:
          'Influenza, commonly known as "the flu", is an infectious disease caused by an influenza virus. Symptoms can be mild to severe. The most common symptoms include: high fever, runny nose, sore throat, muscle and joint pain, headache, coughing, and feeling tired. These symptoms typically begin two days after exposure to the virus and most last less than a week.',
      treatment: ['Anitviral drugs', 'Rest', 'Fluids']),
  Virus(
      name: "Haptitis",
      image: 'assets/images/herpes_virus.png',
      symptoms: 'Skin discoloration,loss of appetite,abdominal pain',
      proteins: [
        'RNA',
        'Hemagglutinin',
        'neuraminidase',
        'Protein Evelope',
        'Lipid Envelope'
      ],
      duration: '~ 1 week',
      frequency: '3-5 million per year',
      death: '~ 375,000 per year',
      description:
          'Influenza, commonly known as "the flu", is an infectious disease caused by an influenza virus. Symptoms can be mild to severe. The most common symptoms include: high fever, runny nose, sore throat, muscle and joint pain, headache, coughing, and feeling tired. These symptoms typically begin two days after exposure to the virus and most last less than a week.',
      treatment: ['Anitviral drugs', 'Rest', 'Fluids']),
  Virus(
      name: "HIV",
      image: 'assets/images/hiv.png',
      symptoms: 'Cough, high temperature, headache, loss of appetite',
      proteins: [
        'RNA',
        'Hemagglutinin',
        'neuraminidase',
        'Protein Evelope',
        'Lipid Envelope'
      ],
      duration: '~ 1 week',
      frequency: '3-5 million per year',
      death: '~ 375,000 per year',
      description:
          'Influenza, commonly known as "the flu", is an infectious disease caused by an influenza virus. Symptoms can be mild to severe. The most common symptoms include: high fever, runny nose, sore throat, muscle and joint pain, headache, coughing, and feeling tired. These symptoms typically begin two days after exposure to the virus and most last less than a week.',
      treatment: ['Anitviral drugs', 'Rest', 'Fluids']),
];
