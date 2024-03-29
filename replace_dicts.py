escape_character_dict = {
    "&lt;": "<",
    "&gt;": ">",
    "&#61;": "=",
    "&#34;": "\"",
    "&#43;": "+"
}

gender_dict = {
    "kvinne": "f",
    "Kvinne": "f",
    #"k": "Kvinne",
    #"ho": "Kvinne",
    #"Ho": "Kvinne",
    "jente": "f",
    "Jente": "f",
    "kvinne/jente": "f",
    "Kvinne/Jente": "f",
    "Kvinne/Kvinne": "f",

    "Mann": "m",
    "mann": "m",
    "gutt": "m",
    #"m": "Mann",
    "man": "m",
    "Jeg er mann": "m",
    "Boolean(Mann)": "m",
    "Mannan": "m",
    "Gut": "m"
}

uib = "UiB"
ntnu = "NTNU"
uis = "UiS"
hvl = "HvL"
uio = "UiO"
kristiania = "Kristiania"
nmbu = "NMBU"

all_institutions = [uib, ntnu, uis, hvl, uio, kristiania, nmbu]

institution_dict = {
    # UiB
    "uib": "UiB",
    "Universitetet i bergen": uib,
    "Universitetet i Bergen": uib,
    "Universitet i Bergen": uib,
    "universitetet i bergen": uib,
    "Universitetet i Bergen (MatNat)": uib,
    "Universitet i Bergen (uib)": uib,
    "universitetet i Bergen": uib,
    "UiB (MatNat)": uib,
    "UiB (UiB)": uib,
    "Aarhus Universitet / UiB": uib,
    "UIB- UiB": uib,
    "UiB (UIB)": uib,
    "univeristetet i bergen": uib,
    "UiB og NHH": uib,
    "Universitet in Bergen": uib,
    "UiB (mattnat)": uib, 
    "UiB, UiB": uib,


    # UiS
    "Stavanger": uis,
    "Uis": uis,
    "uis": uis,
    "UIS": uis,
    "Stavanger universitet": uis,
    "Universitetet i UiS": uis,
    "universitetet i stavanger": uis,
    "Universitet i stavanger": uis,
    "UIS, universitetet i UiS": uis,
    "universitetet i stavanger": uis,
    "Universitet i UiS": uis,
    "UiS Universitet": uis,
    "UiS Universitet": uis,

    # NTNU
    "NTNU - Trondheim": ntnu,
    "NTNU Gløshaugen": ntnu,
    "Ntnu": ntnu,
    "ntnu": ntnu,
    "Universitet i stavanger": ntnu,
    "NTNU-Trondheim": ntnu,
    "NTNU gløshaugen": ntnu,
    "NTNU campus Gløshaugen": ntnu,
    "NTNU Trondheim (Gløs)": ntnu,
    "Norges teknisk-naturvitenskapelige universitet - NTNU": ntnu,
    "NTNU (Ålesund)": ntnu,
    "NTNU Handelshøyskolen, Trondheim ": ntnu,
    "NTNU handelshøyskolen": ntnu,
    "NTNU Gjøvik": ntnu,
    "trondheim": ntnu,
    "Trondheim": ntnu,
    "NTNU gjøvik TDT4111": ntnu,
    "NTNU Trondheim": ntnu,
    "NTNU, Trondheim": ntnu,
    "Gjøvik NTNU": ntnu,
    "NTNU - Campus Gløshaugen": ntnu,
    "NTNU, Gløshaugen": ntnu,
    "NTNU-Gløshaugen": ntnu,
    "NTNU (Trondheim)": ntnu,
    "NTNU NTNU": ntnu,
    "NTNU Gløs": ntnu,
    "Gjøvik": ntnu,
    "NTNU GLØS": ntnu,
    "NTNU Trondheim Kalvskinnet/Gløshaugen": ntnu,
    "Gjøvik (fjernundervisning)": ntnu,
    "NTNU Dragvoll": ntnu,
    "NTNU Handelshøyskolen i Trondheim": ntnu,
    "Ålesund": ntnu,
    "NTNU Trondheim, TDT4111": ntnu,
    "NTNU, TDT4109, Trondheim": ntnu,
    "NTNU NTNU": ntnu,
    "NTNU Campus NTNU": ntnu,
    "Norges Teknisk-Naturvitenskapelige universitet": ntnu,
    "NTNU Handelshøyskolen (NTNU)": ntnu,
    "NTNU (Gløshaugen)": ntnu,
    "Norges tekniske naturvitenskaplige universitet": ntnu,
    "NTNU (Gløshaugen)": ntnu,
    "NTNU Handelshøyskolen (NTNU)": ntnu,
    "Norges tekniske naturvitenskaplige universitet": ntnu,
    "NTNU, NTNU \r\nTDT4111": ntnu,
    "NTNU.": ntnu,

    # HvL
    "Høgskolen på Vestlandet": hvl,
    "Høyskole på vestlandet": hvl,
    "HVL Bergen": hvl,
    "HVL": hvl,
    "Hvl": hvl,
    "HVL Førde": hvl,
    "Høgskulen på Vestlandet": hvl,
    "Høgskolen på Vestlandet (HVL)": hvl,
    "Høgskulen på vestlandet": hvl,
    "HVl i Førde": hvl,
    "høgskulen på vestlandet bergen": hvl,
    "HvL - Bergen": hvl,
    "høgskulen på vestlandet (campus bergen)": hvl,
    "Høgskulen på Vestland": hvl,

    #UiO
    "Universitetet i Oslo": uio,
    "universitetet i oslo": uio,
    "Universitetet i oslo": uio,
    "Uio": uio,
    "UIO": uio,
    "uio": uio,
    "Universitet i Oslo": uio,
    "Universitetet i Oslo, IFI": uio,
    "Universitetet I Oslo": uio,
    "Universitetet I oslo": uio,
    "UiO, IFI": uio,

    # Kristiania
    "Høyskolen Kristiania Oslo": kristiania,
    "Høyskolen Kristiania": kristiania,
    "kristiania": kristiania,

    #NMBU
    "NMBU": nmbu,
    "nmbu": nmbu,
    "NMBU - Norges miljø og biovitenskapelige universitet": nmbu,
    "NMBU (Norges- miljø og biovitenskapelige universitet)": nmbu,
    "NMBU i Ås": nmbu,
    "NMBU Norges miljø og biovitenskaplige universitet": nmbu,
    "NMBU, HIOF": nmbu,
    "NMBU.": nmbu,
    "Norges Miljø og Biovitenskapelige Universitet": nmbu,
    "Norges Miljø- og Biovitenskapelige Universitet (NMBU)": nmbu
}