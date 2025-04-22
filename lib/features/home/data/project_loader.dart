import 'package:zbk_portfolio/features/home/domain/project.dart';

class ProjectLoader {
  Future<List<Project>> loadProjects() async {
    return [
      const Project(
        category: ProjectCategory.webApp,
        title: 'ZBK Portfolio',
        description: 'My personal portfolio app',
        imageUrl: 'assets/images/portfolio.png',
        technologies: ['Flutter', 'Dart'],
        githubUrl: "github.com/zaid-kamil/zbk_portfolio",
        url: "https://zaidkamil.socialmistry.com",
        difficultyLevel: 5,
      ),
      const Project(
        category: ProjectCategory.dataScience,
        title: 'Dputils Library',
        description:
            'A Python utility library to simplify web scraping and document data extraction. Integrated support for handling structured and unstructured data efficiently. Used by developers for data mining, NLP preprocessing, and automation tasks.',
        technologies: ['Python', 'Web Scraping', 'NLP', 'Data Mining'],
        url: "https://pypi.org/project/dputils",
        githubUrl: "https://github.com/digipodium/dputils",
        imageUrl: 'assets/images/dputils.png',
        difficultyLevel: 8,
      ),
      const Project(
          category: ProjectCategory.dataScience,
          title: 'Pit - Python Based Version Control System',
          description:
              'Implemented core functionalities like init, add, commit, and log. Designed repository structuring, object storage, and commit tracking to enhance understanding of Git\'s internal mechanisms.',
          technologies: ['Python', 'Version Control', 'Git'],
          githubUrl: "https://github.com/zaid-kamil/pit",
          imageUrl: 'assets/images/pit.png',
          url: "https://pypi.org/project/pit",
          difficultyLevel: 6),
      const Project(
          category: ProjectCategory.webApp,
          title: 'Train Easy – AI Model Training Pipeline',
          description:
              'A Django-based web application designed to simplify the process of training machine learning models. It provides a user friendly interface to upload datasets, select preprocessing steps, choose algorithms, and evaluate model performance with various metrics.',
          technologies: ['Python', 'Django', 'Machine Learning', 'AI'],
          githubUrl: "https://github.com/zaid-kamil/Train_easy",
          imageUrl: 'assets/images/train_easy.png',
          difficultyLevel: 10,
          screenshots: [
            'assets/images/train_easy.png',
          ]),
      const Project(
          category: ProjectCategory.webApp,
          title: 'Virtual Assistance for the Blind',
          description:
              'Developed an AI-driven email system that enables visually impaired users to send and receive emails using voice commands. Built using Django, HTML5, CSS3, and JavaScript, ensuring accessibility and ease of use for blind users.',
          technologies: [
            'Python',
            'Django',
            'AI',
            'Accessibility',
            'HTML5',
            'CSS3',
            'JavaScript'
          ],
          githubUrl:
              "https://github.com/zaid-kamil/Virtual-Assistance-For-The-Blind",
          imageUrl: 'assets/images/blind_assist.png',
          difficultyLevel: 7),
      const Project(
          category: ProjectCategory.dataScience,
          title: 'Amazon Reviews Analysis',
          description:
              'Developed a Python-based system to scrape, analyze, and visualize Amazon product reviews using BeautifulSoup, TextBlob, and Streamlit. Implemented sentiment analysis with an interactive Streamlit interface to provide insights into customer feedback trends.',
          technologies: [
            'Python',
            'BeautifulSoup',
            'TextBlob',
            'Streamlit',
            'Sentiment Analysis'
          ],
          githubUrl: "https://github.com/zaid-kamil/amazon-reviews-analysis",
          imageUrl: 'assets/images/amazon_reviews.png',
          difficultyLevel: 6),
      const Project(
          category: ProjectCategory.mobileApp,
          title: 'Fiery-App',
          description:
              'Built an Android app integrating Firebase services and REST APIs.',
          technologies: ['Jetpack Compose', 'Firebase', 'Kotlin', 'REST API'],
          githubUrl: "https://github.com/zaid-kamil/Fiery-App",
          imageUrl: 'assets/images/fiery_app.png',
          difficultyLevel: 2,
          screenshots: [
            'assets/images/fiery_app.png',
            'assets/images/fiery_app2.png',
          ]),
      const Project(
          category: ProjectCategory.mobileApp,
          title: 'SpeedTest App',
          description:
              'Designed an internet speed testing app with UI animations.',
          technologies: ['Jetpack Compose', 'Kotlin', 'Animations'],
          githubUrl: "https://github.com/zaid-kamil/SpeedTest-compose",
          imageUrl: 'assets/images/speedtest_app.jpg',
          difficultyLevel: 6),
      const Project(
          category: ProjectCategory.mobileApp,
          title: 'Diabetes Classifier App',
          description:
              'Built a real-time diabetes prediction app using Dart ML libraries.',
          technologies: ['Flutter', 'ML', 'Dart'],
          githubUrl: "https://github.com/zaid-kamil/diabetes_classifier_app",
          imageUrl: 'assets/images/diabetes.png',
          difficultyLevel: 7),
      const Project(
          category: ProjectCategory.mobileApp,
          title: 'House Price Prediction App',
          description:
              'Implemented an ML model for real-time house price prediction.',
          technologies: ['Flutter', 'TensorFlow', 'ML'],
          githubUrl:
              "https://github.com/zaid-kamil/flutter_house_price_prediction",
          imageUrl: 'assets/images/house_price.png',
          difficultyLevel: 8),
      const Project(
          category: ProjectCategory.mobileApp,
          title: 'Image Recognition App',
          description:
              'Developed a web-based image recognition tool using AI models.',
          technologies: ['Flutter', 'HuggingFace API', 'AI', 'ML'],
          githubUrl: "https://github.com/zaid-kamil/image_recognition_app",
          imageUrl: 'assets/images/image_recognition.png',
          difficultyLevel: 6),
      const Project(
        title: 'Cloud Technical Series AI Deep Dive',
        description:
            'Issued by Google Cloud Asia Pacific\nCredential ID: 133127404',
        category: ProjectCategory.certificates,
        technologies: ['Cloud', 'AI'],
        url: "https://www.credential.net/77e0442e-960c-44fc-a64b-f2826a4b2817",
      ),
      const Project(
        title: 'Google Play Store Listing Certificate',
        description:
            'Issued by Google Play Academy\nCredential ID: 128561205\nValid: Jan 2025 - Jan 2028',
        category: ProjectCategory.certificates,
        technologies: ['Google Play Store', 'App Publishing'],
        url: "https://www.credential.net/3420b5d5-cc71-40f5-81fe-ca08900e2990",
        imageUrl: "assets/images/google_play_academy.png",
      ),
      const Project(
        title: 'Introduction to Data Analytics on Google Cloud',
        description: 'Issued by Google\nCredential ID: 13472157',
        category: ProjectCategory.certificates,
        technologies: ['Data Analytics', 'Google Cloud'],
        url:
            "https://www.cloudskillsboost.google/public_profiles/23b77b8a-b1b1-44fb-9139-725c75903f2e/badges/13472157?utm_medium=social&utm_source=linkedin&utm_campaign=ql-social-share",
      ),
      const Project(
        title: 'Python Essentials 1',
        description: 'Issued by Cisco',
        category: ProjectCategory.certificates,
        technologies: ['Python'],
        url:
            "https://www.credly.com/badges/ba779349-5e49-4544-b39f-b192d31dbe2f/linked_in_profile",
        imageUrl: "assets/images/python_essentials.png",
      ),
      const Project(
        title: 'Data Science 101',
        description:
            'Issued by IBM SkillsBuild\nCredential ID: e14b11894ad346418d4106f4543640f8',
        category: ProjectCategory.certificates,
        technologies: ['Data Science', 'Analytics', 'Python Programming'],
        url:
            "https://courses.skillsbuild.skillsnetwork.site/certificates/e14b11894ad346418d4106f4543640f8",
      ),
      const Project(
        title: 'Data Science Tools',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: [
          'Analytics',
          'Python',
          'Python Programming',
          'Data Engineering'
        ],
        url:
            "https://www.credly.com/badges/14c409ef-cc8d-49e3-8514-7fbb155575f3/linked_in_profile",
      ),
      const Project(
        title: 'Machine Learning with Python - Level 1',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Python Programming'],
        url:
            "https://www.credly.com/badges/3d663787-b600-45a2-b799-eb7f47149001/linked_in_profile",
        imageUrl: "assets/images/machine_learning_with_python.png",
      ),
      const Project(
        title: 'SQL and Relational Databases 101',
        description:
            'Issued by IBM SkillsBuild\nCredential ID: 5092a316a3c44cabbb8809107eea8983',
        category: ProjectCategory.certificates,
        technologies: ['MySQL', 'SQL', 'Databases'],
        url:
            "https://courses.skillsbuild.skillsnetwork.site/certificates/5092a316a3c44cabbb8809107eea8983",
      ),
      const Project(
        title: 'Prompt Engineering for Everyone',
        description:
            'Issued by IBM SkillsNetwork\nCredential ID: course-v1:IBMSkillsNetwork AI0117EN v1',
        category: ProjectCategory.certificates,
        technologies: ['Generative AI'],
        url:
            "https://courses.cognitiveclass.ai/certificates/bb44e48225754e7e8cf23591cf90fbc6",
      ),
      const Project(
        title: 'Automate ML Pipelines Using Apache Airflow',
        description:
            'Issued by IBM\nCredential ID: course-v1:IBM GPXX0DNQEN v1',
        category: ProjectCategory.certificates,
        technologies: ['Python Programming', 'Apache Airflow'],
        url:
            "https://courses.cognitiveclass.ai/certificates/5acf353a8b764f74a7e20a2599ae1ddf",
      ),
      const Project(
        title: 'Image Segmentation with Mean Shift Clustering',
        description:
            'Issued by IBM SkillsNetwork\nCredential ID: course-v1:IBMSkillsNetwork GPXX04YGEN v1',
        category: ProjectCategory.certificates,
        technologies: ['Python Programming', 'Image Segmentation'],
        url:
            "https://courses.cognitiveclass.ai/certificates/17645098c32d440999b4fe64ef02f025",
      ),
      const Project(
        title: 'Enterprise Design Thinking Practitioner',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Design Thinking'],
        url:
            "https://www.credly.com/badges/9c7aa05c-6ac0-4c51-82e6-82c9aa0019d9/linked_in_profile",
        imageUrl: "assets/images/enterprise_design_thinking.png",
      ),
      const Project(
        title: 'Cloud Core',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Cloud Computing'],
        url:
            "https://www.credly.com/badges/f784cddf-806e-4f50-930c-fd617d83834a/linked_in_profile",
      ),
      const Project(
        title: 'IBM Cloud Essentials',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Cloud Computing'],
        url:
            "https://www.credly.com/badges/43555279-4cfa-449b-a929-d0ae21dc0c48/linked_in_profile",
        imageUrl: "assets/images/ibm_cloud_essentials.png",
      ),
      const Project(
        title: 'Applied Data Science with Python - Level 2',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Analytics', 'Python Programming'],
        url:
            "https://www.credly.com/badges/52283130-4adf-449f-9943-68e576b5a1c5/linked_in_profile",
      ),
      const Project(
        title: 'Data Analysis Using Python',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Analytics', 'Python Programming'],
        url:
            "https://www.credly.com/badges/63827ced-b04d-428c-b537-5a50837c913b/linked_in_profile",
        imageUrl: "assets/images/data_analysis_using_python.png",
      ),
      const Project(
        title: 'Data Science Foundations - Level 2 (V2)',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Data Science', 'Analytics', 'Python Programming'],
        url:
            "https://www.credly.com/badges/84136163-94e9-4216-a87c-5025dad64ec1/linked_in_profile",
        imageUrl:
            "assets/images/data_science_foundations_with_python_level_2.png",
      ),
      const Project(
        title: 'Data Science Methodologies',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Data Science', 'Analytics'],
        url:
            "https://www.credly.com/badges/ae263276-176d-4a9c-9fad-7d9527660b67/linked_in_profile",
      ),
      const Project(
        title: 'Data Visualization Using Python',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Analytics', 'Python Programming'],
        url:
            "https://www.credly.com/badges/0559521a-e89f-4593-94a3-557350448e86/linked_in_profile",
      ),
      const Project(
        title: 'Python for Data Science',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Analytics', 'Python', 'Pandas', 'Python Programming'],
        url:
            "https://www.credly.com/badges/c8a0b1f9-ecae-4980-9ab1-aa51c5ede18b/linked_in_profile",
        imageUrl: "assets/images/python_for_data_science.png",
      ),
      const Project(
        title: 'Data Science Foundations - Level 1',
        description: 'Issued by IBM',
        category: ProjectCategory.certificates,
        technologies: ['Analytics'],
        url:
            "https://www.credly.com/badges/0bd41153-7e17-48ca-870d-0db4feb47565/linked_in_profile",
      ),
      const Project(
        title: 'Associate Android Developer',
        description:
            'Issued by Google for Developers\nCredential ID: 10943363\nValid: May 2017 - May 2020',
        category: ProjectCategory.certificates,
        technologies: [
          'Debugging',
          'OOP',
          'Clean Coding',
          'Object Oriented Design',
          'UI Design',
          'Mobile Apps',
          'Coroutines',
          'Mobile Architecture'
        ],
        url:
            "https://www.credential.net/u2ufqxxm?key=1e566317c54f4f4aa751f9a229f9da9d2975e31aa3e8ab28f4efcf1001f9d4bd",
        imageUrl: "assets/images/associate_android_developer.png",
      ),
      const Project(
        category: ProjectCategory.dataScience,
        // Replace with an actual ProjectCategory enum value
        title: "Automobile Dashboard App",
        description:
            "The app provides various functionalities to visualize and explore the data, including numerical analysis, textual analysis, and correlation analysis.",
        technologies: ["Python", "Pandas", "Plotly", "Streamlit"],
        imageUrl: "assets/images/automobile_dashboard.png",
        githubUrl: "https://github.com/zaid-kamil/Automobile_Dashboard_App",
        url:
            "https://zaid-kamil-automobile-dashboard-app-app-zuc0at.streamlit.app/",
        difficultyLevel: 3,
        screenshots: [
          "assets/images/automobile_dashboard.png",
          "assets/images/automobile_dashboard2.png",
          "assets/images/automobile_dashboard3.png",
        ],
        videoUrl: "https://www.youtube.com/watch?v=SqKjYOzeKZw",
      ),
      const Project(
        title: 'Problem Solving (Basic)',
        description: 'Issued by HackerRank',
        category: ProjectCategory.certificates,
        technologies: ['Data Structures'],
        url: "https://www.hackerrank.com/certificates/df10e7f8163d",
      ),
      const Project(
        title: 'Python (Basic)',
        description: 'Issued by HackerRank',
        category: ProjectCategory.certificates,
        technologies: ['Python Programming'],
        url: "https://www.hackerrank.com/certificates/4d6fa264282e",
      ),
      const Project(
          title: 'SQL (Intermediate)',
          description: 'Issued by HackerRank',
          category: ProjectCategory.certificates,
          technologies: ['SQL'],
          url: "https://www.hackerrank.com/certificates/a2fc6c795cb8"),
    ];
  }
}
