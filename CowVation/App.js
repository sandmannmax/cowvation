import Login from './src/components/Login/Login'
import Liste from './src/components/Liste/Liste'
import Cow from './src/components/Cow/Cow'
import CowAdd from './src/components/CowAdd/CowAdd'
import CowEdit from './src/components/CowEdit/CowEdit'
import CameraComponent from './src/components/CameraComponent/CameraComponent';
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