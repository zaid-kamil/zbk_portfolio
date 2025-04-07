import 'package:zbk_portfolio/features/home/domain/project.dart';

class ProjectLoader {
  Future<List<Project>> loadProjects() async {
    return [
      Project(
        category: ProjectCategory.webApp,
        title: 'ZBK Portfolio',
        description: 'My personal portfolio app',
        imageUrl: 'assets/images/portfolio.png',
        technologies: ['Flutter', 'Dart'],
        githubUrl: "github.com/zaid-kamil/zbk_portfolio",
        url: "https://zaidkamil.socialmistry.com",
        difficultyLevel: 5,
      ),
      // New data science projects
      const Project(
        category: ProjectCategory.dataScience,
        title: 'Dputils Library',
        description:
            'A Python utility library to simplify web scraping and document data extraction. Integrated support for handling structured and unstructured data efficiently. Used by developers for data mining, NLP preprocessing, and automation tasks.',
        technologies: ['Python', 'Web Scraping', 'NLP', 'Data Mining'],
        url: "https://pypi.org/project/dputils",
        githubUrl: "https://github.com/digipodium/dputils",
        imageUrl: 'assets/images/dputils.png',
        difficultyLevel: 8
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
        difficultyLevel: 6
      ),

      const Project(
        category: ProjectCategory.webApp,
        title: 'Train Easy – AI Model Training Pipeline',
        description:
            'A Django-based web application designed to simplify the process of training machine learning models. It provides a user friendly interface to upload datasets, select preprocessing steps, choose algorithms, and evaluate model performance with various metrics.',
        technologies: ['Python', 'Django', 'Machine Learning', 'AI'],
        githubUrl: "https://github.com/zaid-kamil/Train_easy",
        imageUrl: 'assets/images/train_easy.png',
        difficultyLevel: 10
      ),

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
        difficultyLevel: 7
      ),

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
        difficultyLevel: 6
      ),

      const Project(
        category: ProjectCategory.mobileApp,
        title: 'Fiery-App',
        description:
            'Built an Android app integrating Firebase services and REST APIs.',
        technologies: ['Jetpack Compose', 'Firebase', 'Kotlin', 'REST API'],
        githubUrl: "https://github.com/zaid-kamil/Fiery-App",
        imageUrl: 'assets/images/fiery_app.png',
        difficultyLevel: 3
      ),

      const Project(
        category: ProjectCategory.mobileApp,
        title: 'SpeedTest App',
        description:
            'Designed an internet speed testing app with UI animations.',
        technologies: ['Jetpack Compose', 'Kotlin', 'Animations'],
        githubUrl: "https://github.com/zaid-kamil/SpeedTest-compose",
        imageUrl: 'assets/images/speedtest_app.jpg',
        difficultyLevel: 6
      ),

      const Project(
        category: ProjectCategory.mobileApp,
        title: 'Diabetes Classifier App',
        description:
            'Built a real-time diabetes prediction app using Dart ML libraries.',
        technologies: ['Flutter', 'ML', 'Dart'],
        githubUrl: "https://github.com/zaid-kamil/diabetes_classifier_app",
        imageUrl: 'assets/images/diabetes.png',
        difficultyLevel: 7
      ),

      const Project(
        category: ProjectCategory.mobileApp,
        title: 'House Price Prediction App',
        description:
            'Implemented an ML model for real-time house price prediction.',
        technologies: ['Flutter', 'TensorFlow', 'ML'],
        githubUrl:
            "https://github.com/zaid-kamil/flutter_house_price_prediction",
        imageUrl: 'assets/images/house_price.png',
        difficultyLevel: 8
      ),

      const Project(
        category: ProjectCategory.mobileApp,
        title: 'Image Recognition App',
        description:
            'Developed a web-based image recognition tool using AI models.',
        technologies: ['Flutter', 'HuggingFace API', 'AI', 'ML'],
        githubUrl: "https://github.com/zaid-kamil/image_recognition_app",
        imageUrl: 'assets/images/image_recognition.png',
        difficultyLevel: 6
      ),
    ];
  }
}
