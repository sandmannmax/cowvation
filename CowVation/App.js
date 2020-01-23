import Login from './components/Login/Login';
import Liste from './components/Liste/Liste';
import Cow from './components/Cow/Cow';
import CowAdd from './components/CowAdd/CowAdd';
import CowEdit from './components/CowEdit/CowEdit'
import CameraComponent from './components/CameraComponent/CameraComponent';
import {createAppContainer} from 'react-navigation';
import {createStackNavigator} from 'react-navigation-stack';

const MainNavigator = createStackNavigator({
    Login: {screen: Login},
    Liste: {screen: Liste},
    Cow: {screen: Cow},
    CowAdd: {screen: CowAdd},
    CowEdit: {screen: CowEdit},
    Camera: {screen: CameraComponent},
  });

const App = createAppContainer(MainNavigator);

export default App;