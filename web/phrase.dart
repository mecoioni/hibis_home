class Phrase
{
  Phrase(this.language);

  String get(String key) => data[language].containsKey(key) ? data[language][key] : key;

  Map<String, Map<String, String>> data =
  {
    "en":
    {
      "address_helsinki" : "Centry Ltd<br />Ratatie 11<br />01300 Vantaa<br />Finland",
      "address_london" : "Hibis Europe Ltd",
      "address_malmo" : "Hibis AB",
      "address_oslo" : "Septia AS<br /> Meltzersgt. 4<br/> 0275 Oslo<br/> Norway",
      "address_stockholm" : "Hibis AB",
      "contact" : "contact",
      "contact_us" : "contact<br />us",
      "contact_helsinki" : "<strong>Petri Kelo</strong><br /> <a href='mailto:petri.kelo@centry.global'>petri.kelo@centry.global</a><br /> + 358 40 50 001 068",
      "contact_london" : "<strong>Allan McDonagh</strong><br /> <a href='mailto:allan.mcdonagh@hibis.com'>allan.mcdonagh@hibis.com</a><br /> + 44 77 68 32 0161",
      "contact_malmo" : "<strong>Richard Minogue</strong><br /><a href='mailto:richard.minogue@hibis.com'>richard.minogue@hibis.com</a><br />+ 46 761 882 497",
      "contact_oslo" : "<strong>Veronica Morino</strong><br /> <a href='mailto:veronica.morino@septiagroup.com'>veronica.morino@septiagroup.com</a><br /> + 47 91 86 32 19 <br/><br/> <strong>Nigel Krishna Iyer</strong><br /> <a href='mailto:nigel.iyer@septiagroup.com'>nigel.iyer@septiagroup.com</a><br /> + 47 90 65 44 10<br/> + 44 7523 570004 (UK)",
      "contact_stockholm" : "<strong>Richard Minogue</strong><br /><a href='mailto:richard.minogue@hibis.com'>richard.minogue@hibis.com</a><br />+ 46 761 882 497",
      "copyright" : "&copy;2017 Hibis. All rights reserved. Design by SoiaDg.",
      "frontpage_title" : "<strong>Fraud and corruption <span class='orange-text'>can</span> be stopped</strong>",
      "hibis_associates" : "hibis associates",
      "hibis_people" : "hibis people",
      "helsinki" : "Helsinki",
      "london" : "London",
      "malmo" : "Malmö",
      "oslo" : "Oslo",
      "our_history" : "our history",
      "our_history_text" : "<p>Hibis was founded in 1998 by Martin Samociuk. Many of the people who joined at the start came from Network Security Management in London, a company which pioneered fraud investigation and prevention in the 1980’s and 90’s. In 1999, Martin was joined by Nigel Krishna Iyer and one year later by Allan McDonagh. Veronica Morino became part of the group in 2001 followed by Richard Minogue in 2002. The mission of Hibis has always been to put prevention and early detection FIRST. We share with clients the need to dramatically raise awareness of fraud and corruption, give them the ability to spot it early and provide advice and resources for well managed investigations. This includes training workshops, seminars, books, publications and films all with the purpose of stimulating this greater awareness and self-reliance.</p><p>Hibis has been in continuous operation in the UK since 1999 and in Australia from 2003 to 2013 and in Scandinavia from 1999 – 2008. Today we are proud to again use the Hibis name in Scandinavia. </p>",
      "profile_allan" : "Allan's long experience from 1967 includes UK Customs and Excise Investigations and New Scotland Yard, where he specialized in narcotics and organised crime. Between 1985 and 1997 Allan worked as Deputy Managing Director with Martin Samociuk at Network Security Management Limited.",
      "profile_carina" : "Carina Sörqvist has a long experience of preventing and investigating fraud and corruption. She has worked as a Consultant since 2003, before that she worked with compliance in a multinational company. Carina has a financial background and her specialities are forensic accounting and interview techniques.",
      "profile_john" : "John Wallhoff (BSc, CISA, CISM, CISSP), a computer security and data-analysis expert for many years, develops and implements data models to detect patterns of fraud and corruption. John participates in investigations, leads trainings and supports his colleagues through development of leading edge models to pinpoint patterns of malpractice and unethical business behavior.",
      "profile_martina" : "Martina has a combined Masters degree in Business and Economics (majoring in finance) from the Norwegian Business School (BI) and the University of Ljubljana (Slovenia). Right from an early age she wanted to play an active part in eradicating systematic inefficiencies. She recognized that corruption and fraud is one of the major obstacles to sustainability and growth and was able to apply her passion at Hibis.",
      "profile_nigel" : "Nigel has over 20 years experience investigating and detecting fraud and corruption. A computer scientist and qualified chartered accountant Nigel soon found that his true passion lay in rooting out corruption and fraud. Nigel is also today a qualified dramatist and has written a number of films and plays based on experiences, many of which are used in teaching worldwide.",
      "profile_petri" : "Petri Kelo is Hibis’ associated partner in  Finland. His academic background includes a Masters of Security from Helsinki University of Technology. Petri has worked for over 20 years with logistics, quality, security, as well as managing the risk of fraud and corruption. Petri is also the founder of Centry Ltd. a security company specialized in logistics, supply chain, security risk management, compliance and investigative services. He is a well known speaker and trainer in AEO, TAPA and logistics security, as well as an active member of ASIS Finland.",
      "profile_richard" : "Since his first full time job as internal auditor starting in 1975, Richard has accumulated experience in audit, investigation, financial control, and general management. Inquisitive by nature, he knows there is usually more than one right way to do things, and many wrong ways.",
      "profile_stuart" : "Stuart joined Hibis full time in 2016 to establishing management strategies to prevent, detect and where necessary investigate fraud and corruption. He has also been involved part-time with Hibis since 2002 with a special interest in building awareness resistance and resilience at both the individual and organizational levels. Stuart has MSc degrees in management and sustainability, giving him the necessary tools as a systems thinker to approach problems from a holistic perspective. With a background in the IT-industry, he has been involved with building start-ups, consulting in organizational development, leadership and management training.",
      "profile_veronica" : "Veronica has over 15 years experience investigating, finding and training others on how to prevent and manage fraud and corruption around the world. A sociologist of work and economics with a masters in organisational science, she has developed holistic desktop investigative research and analysis tools to explore organisations, business partners, suppliers, customers and key individuals.",
      "red_flag_game" : "The<br /><span class='red-text'>red</span><br />flag<br />Game",
      "rules_game" : "how far<br />can you<br />bend the<br />rules?",
      "stockholm" : "Stockholm",
      "the_fraud_academy" : "the fraud academy",
      "what_we_do" : "what we do",
      "what_we_do_collapsed_text_1" : "<p>We are a small group of investigation experts who work quickly and effectively. We have a track record of solving our client’s problems efficiently and with compassion. We believe in the beauty of small investigations that win back value. It is not necessary to chase every suspicion when finding and fixing the “whys” and the “hows” resolves the problem.</p><p>Of course from time to time exceptional situations occur. When an organisation needs to prepare legal actions to recover major assets or save a business, a deep investigation may be required. We manage investigations, large or small, in a controlled way avoiding unnecessary expenditure and keeping the client in the driver’s seat.</p>",
      "what_we_do_collapsed_text_2" : "<p>There is plenty of fraud and corruption around that needs to be found (preferably in the early stages) and stopped. Usually fraudulent and corruptdd activities are cloaked in legitimacy, and finding the truth requires professional scepticism, experience and effort. Our proven methods include:</p><ul><li>Delving into the details and performing structured analysis on transactions, data and documents to find the red flags</li><li>Convening “thinking like a thief” sessions (an approach invented in the 1980’s by Martin Samociuk, Hibis’ founder) to anticipate how the fraudsters’ mind works and build a profile of the types of frauds that are occurring or likely to occur</li><li>Finding behavioural red flags by performing holistic desktop investigative research and analysis of organisations, business partners, suppliers, customers and key individuals. All with a special focus on opportunities, motives and how people rationalize dishonest or unethical behaviour</li></ul><p>If not detected early, fraud and corruption will spread. Eventually, the problem will be discovered when it becomes too large to ignore, or is reported by whistle-blowers, or both. But why wait for the whistle-blower when you can use fraud detective techniques and uncover where early stage fraud and corruption is developing now? It’s better to stay ahead of the game!</p>",
      "what_we_do_collapsed_text_3" : "<p>We probably will never totally eradicate fraud and corruption. But by raising awareness and managing the risks we can control the cost and make corrupt behaviour less acceptable. Surprisingly, much fraud and corruption involves normal, good people such as valuable and trusted employees or business partners. Awareness is a powerful tool to help good people avoid bad mistakes they will later regret, and to show them how to protect the organisation against career fraudsters. As Nelson Mandela said, education is one of the most powerful ways to change the world. We have developed courses and techniques to bridge the skills gap and constantly look for innovative new ways to raise the awareness, spread knowledge and bring people together in the fight of corruption and fraud. Examples (details can be found in our <strong><a href='http://fraudacademy.hibis.com' target='_blank'>Fraud Academy</a></strong> page) include:</p><ul><li>Practical open courses and workshops (including our \"think like a thief methodology\" and \"fraud detective school\")</li> <li>Accredited management courses</li> <li>On the job-training, in-house workshops and clinics</li> <li>Multimedia based training delivered over the internet (or intranet)</li> <li>Experiential learning, including drama, scenarios, live simulations, “corruption-theatre” and films</li> <li>Publications and books</li> </ul>",
      "what_we_do_collapsed_text_4" : "<p>The burden of external regulation, designed to protect the public and punish corporate offenders is increasing. This absorbs management attention and leaves less room for more practical programs designed to protect the organisation. Management can fall into the trap of accepting bureaucratic solutions that appear to fulfill regulatory requirements, but which do not effectively address the issue of fraudulent and corrupt behavior. Compliance programs based on checklists are unlikely to be effective!</p><p>We are able to measure the impact and effectiveness of your existing anti-fraud and corruption activities, identifying gaps and potential improvements that will bring down the cost of fraud and corruption and strengthen the ethical culture.</p><p>Our holistic framework and assessment tool brings together years of practical experience with a distillation of the most essential knowledge from widely used existing frameworks. </p>",
      "what_we_do_collapsed_title_1" : "We investigate fraud and corruption",
      "what_we_do_collapsed_title_2" : "We look for fraud and always find it!",
      "what_we_do_collapsed_title_3" : "We raise awareness, share knowledge and transfer skills",
      "what_we_do_collapsed_title_4" : "We assess the effectiveness of existing anti-fraud and corruption programs",
      "what_we_do_list_1_item_1" : "<strong>Finding</strong> and interpreting the many red flags",
      "what_we_do_list_1_item_2" : "<strong>Supporting investigations</strong> in an efficient, responsible and compassionate manner",
      "what_we_do_list_1_item_3" : "<strong>Analysing</strong> the root causes of incidents to identify improvement opportunities",
      "what_we_do_list_1_item_4" : "<strong>Providing</strong> (through practical workshops, training and other innovative devices) the skills to turn what looks like “bad news” into an opportunity to save money (see <a href='http://fraudacademy.hibis.com' target='_blank'>Hibis Fraud Academy</a>)",
      "what_we_do_paragraph_1" : "Fraud and corruption happens all the time and is arguably one of the greatest unmanaged costs in organisations and society today. Yet most management and employees have not had any practical training in this area. Our aim is to significantly raise awareness of fraud and corruption and its consequences. We assist and advise organisations, companies and everyone else concerned by:",
      "what_we_do_paragraph_2": "<strong>Assessing</strong> and <strong>measuring</strong> the <strong>effectiveness</strong>, strengths and weaknesses of existing anti-fraud and corruption programmes",
      "who_we_are" : "who we are",
    }
  };

  String language;

}