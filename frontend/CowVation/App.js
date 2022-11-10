import Login from './src/Login/Login'
import Liste from './src/Liste/Liste'
import Cow from './src/Cow/Cow'
import CowAdd from './src/CowAdd/CowAdd'
import CowEdit from './src/CowEdit/CowEdit'
import CameraComponent from './src/CameraComponent/CameraComponent';
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
